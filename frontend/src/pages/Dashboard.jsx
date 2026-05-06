import { useEffect, useState } from 'react'
import { BadgeDollarSign, BarChart3, Loader2, Users } from 'lucide-react'
import {
  fetchCountrySalaryInsights,
  fetchJobTitleSalaryInsights,
  fetchSalaryDistribution,
} from '../api/salaryInsights'

function formatCurrency(value) {
  if (value === null || value === undefined) return '-'

  return `₹${Number(value).toLocaleString('en-IN')}`
}

function Dashboard() {
  const [country, setCountry] = useState('')
  const [jobTitle, setJobTitle] = useState('')
  const [countryInsights, setCountryInsights] = useState(null)
  const [jobTitleInsights, setJobTitleInsights] = useState(null)
  const [distribution, setDistribution] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const shouldFetchJobTitleInsights = country && jobTitle
  const countries = ['', 'India', 'USA', 'Canada', 'Germany', 'UK']

  const jobTitles = [
    '',
    'Software Engineer',
    'Senior Software Engineer',
    'HR Manager',
    'Product Manager',
    'QA Engineer',
    'DevOps Engineer',
  ]


  useEffect(() => {
    async function loadInsights() {
      try {
        setLoading(true)
        setError('')

        const countryResult =
          await fetchCountrySalaryInsights(country)

        const distributionResult =
          await fetchSalaryDistribution(country)

        setCountryInsights(countryResult.data)
        setDistribution(distributionResult.data)

        if (!country && jobTitle) {
          setJobTitleInsights(null)
          return
        }

        if (country && jobTitle) {
          const jobTitleResult =
            await fetchJobTitleSalaryInsights(country, jobTitle)

          setJobTitleInsights(jobTitleResult.data)
        } else {
          setJobTitleInsights(null)
        }
      } catch {
        setError('Unable to load salary insights. Please check backend server.')
      } finally {
        setLoading(false)
      }
    }

    loadInsights()
  }, [country, jobTitle])
  const cards = [
    {
      title: 'Minimum Salary',
      value: formatCurrency(countryInsights?.minimum_salary),
      icon: BadgeDollarSign,
      description: `Lowest salary in ${countryInsights?.country || country}`,
    },
    {
      title: 'Maximum Salary',
      value: formatCurrency(countryInsights?.maximum_salary),
      icon: BadgeDollarSign,
      description: `Highest salary in ${countryInsights?.country || country}`,
    },
    {
      title: 'Average Salary',
      value: formatCurrency(countryInsights?.average_salary),
      icon: BarChart3,
      description: `Average salary in ${countryInsights?.country || country}`,
    },
    {
      title: 'Employees',
      value: countryInsights?.employee_count || 0,
      icon: Users,
      description: `Employees in ${countryInsights?.country || country}`,
    },
  ]

  return (
    <div className="space-y-6">
      <div className="rounded-3xl bg-slate-950 p-8 text-white shadow-xl">
        <p className="text-sm font-medium text-slate-300">
          Salary Insights
        </p>

        <h1 className="mt-2 text-3xl font-bold">
          Clear compensation analytics for HR decisions
        </h1>

        <p className="mt-3 max-w-2xl text-sm leading-6 text-slate-300">
          View country-wise salary range, average salary, job-title based compensation, and distribution buckets.
        </p>
      </div>

      <div className="grid gap-4 rounded-3xl border border-slate-200 bg-white p-6 shadow-sm md:grid-cols-3">
        <div>
          <label className="text-sm font-semibold text-slate-700">
            Country
          </label>
          <select
            value={country}
            onChange={(event) => setCountry(event.target.value)}
            className="mt-2 w-full rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
          >
            {countries.map((item) => (
              <option key={item || 'all'} value={item}>
                {item || 'All Countries'}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="text-sm font-semibold text-slate-700">
            Job Title
          </label>
          <select
            value={jobTitle}
            onChange={(event) => setJobTitle(event.target.value)}
            className="mt-2 w-full rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
          >
            {jobTitles.map((item) => (
              <option key={item || 'all'} value={item}>
                {item || 'All Job Titles'}
              </option>
            ))}
          </select>
        </div>

        <div className="flex items-end">
          <div className="w-full rounded-2xl bg-slate-50 px-4 py-3 text-sm text-slate-600">
            Data updates automatically when country or job title changes.
          </div>
        </div>
      </div>

      {loading && (
        <div className="flex items-center justify-center gap-3 rounded-3xl bg-white p-10 text-slate-500 shadow-sm">
          <Loader2 className="animate-spin" size={20} />
          Loading insights...
        </div>
      )}

      {error && (
        <div className="rounded-3xl border border-red-200 bg-red-50 p-6 text-sm font-medium text-red-700">
          {error}
        </div>
      )}

      {!loading && !error && (
        <>
          <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-4">
            {cards.map((card) => {
              const Icon = card.icon

              return (
                <div
                  key={card.title}
                  className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm"
                >
                  <div className="rounded-2xl bg-slate-100 p-3 text-slate-900">
                    <Icon size={22} />
                  </div>

                  <p className="mt-5 text-sm font-medium text-slate-500">
                    {card.title}
                  </p>

                  <h3 className="mt-2 text-3xl font-bold text-slate-950">
                    {card.value}
                  </h3>

                  <p className="mt-2 text-sm text-slate-500">
                    {card.description}
                  </p>
                </div>
              )
            })}
          </div>

          <div className="grid gap-6 xl:grid-cols-2">
            <div className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
              <h2 className="text-lg font-bold text-slate-950">
                Job Title Average
              </h2>

              <p className="mt-1 text-sm text-slate-500">
                Average salary for {jobTitleInsights?.job_title} in {jobTitleInsights?.country}
              </p>

              <div className="mt-6 rounded-3xl bg-slate-50 p-6">
                <p className="text-sm font-medium text-slate-500">
                  Average Salary
                </p>

                {jobTitleInsights ? (
  <>
                    <h3 className="mt-2 text-4xl font-bold text-slate-950">
                      {formatCurrency(jobTitleInsights.average_salary)}
                    </h3>

                    <p className="mt-2 text-sm text-slate-500">
                      Based on {jobTitleInsights.employee_count} employee records
                    </p>
                  </>
                ) : (
                  <div className="mt-4 rounded-2xl bg-slate-100 p-4 text-sm text-slate-600">
                    Please select both country and job title to view average salary insights.
                  </div>
                )}
              </div>
            </div>

            <div className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
              <h2 className="text-lg font-bold text-slate-950">
                Salary Distribution
              </h2>

              <p className="mt-1 text-sm text-slate-500">
                Salary bucket distribution in {distribution?.country}
              </p>

              <div className="mt-6 space-y-4">
                {Object.entries(distribution?.distribution || {}).map(
                  ([label, count]) => (
                    <div key={label}>
                      <div className="mb-2 flex items-center justify-between text-sm">
                        <span className="font-medium text-slate-700">
                          {label}
                        </span>
                        <span className="text-slate-500">
                          {count} employees
                        </span>
                      </div>

                      <div className="h-3 rounded-full bg-slate-100">
                        <div
                          className="h-3 rounded-full bg-slate-900"
                          style={{
                            width: `${Math.min(
                              (count / Math.max(countryInsights?.employee_count || 1, 1)) * 100,
                              100
                            )}%`,
                          }}
                        />
                      </div>
                    </div>
                  )
                )}
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  )
}

export default Dashboard
