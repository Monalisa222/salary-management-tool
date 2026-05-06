import { useEffect, useState } from 'react'
import { Mail, BriefcaseBusiness, MapPin, Loader2 } from 'lucide-react'
import { fetchEmployees } from '../api/employees'
import EmployeeFormModal from '../components/EmployeeFormModal'
import { Pencil } from 'lucide-react'

function Employees() {
  const [employees, setEmployees] = useState([])
  const [meta, setMeta] = useState(null)
  const [page, setPage] = useState(1)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [modalOpen, setModalOpen] = useState(false)
  const [refreshKey, setRefreshKey] = useState(0)
  const [selectedEmployee, setSelectedEmployee] = useState(null)

  useEffect(() => {
    async function loadEmployees() {
      try {
        setLoading(true)
        setError('')

        const result = await fetchEmployees(page, 10)

        setEmployees(result.data)
        setMeta(result.meta)
      } catch {
        setError('Unable to load employees. Please check backend server.')
      } finally {
        setLoading(false)
      }
    }

    loadEmployees()
  }, [page, refreshKey])

  return (
    <div className="space-y-6">
      <div className="flex flex-col justify-between gap-4 rounded-3xl bg-white p-6 shadow-sm md:flex-row md:items-center">
        <div>
          <h1 className="text-2xl font-bold text-slate-950">
            Employees
          </h1>
          <p className="mt-1 text-sm text-slate-500">
            Manage employee records and salary details.
          </p>
        </div>

        <button
          onClick={() => {
            setSelectedEmployee(null)
            setModalOpen(true)
          }}
          className="rounded-2xl bg-slate-950 px-5 py-3 text-sm font-semibold text-white shadow-sm hover:bg-slate-800"
        >
          Add Employee
        </button>
      </div>

      <div className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
        {loading && (
          <div className="flex items-center justify-center gap-3 p-10 text-slate-500">
            <Loader2 className="animate-spin" size={20} />
            Loading employees...
          </div>
        )}

        {error && (
          <div className="p-8 text-center text-sm font-medium text-red-600">
            {error}
          </div>
        )}

        {!loading && !error && (
          <>
            <div className="overflow-x-auto">
              <table className="w-full border-collapse text-left">
                <thead className="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                  <tr>
                    <th className="px-6 py-4">Employee</th>
                    <th className="px-6 py-4">Job Title</th>
                    <th className="px-6 py-4">Country</th>
                    <th className="px-6 py-4">Department</th>
                    <th className="px-6 py-4 text-right">Salary</th>
                    <th className="px-6 py-4 text-right">Actions</th>
                  </tr>
                </thead>

                <tbody className="divide-y divide-slate-100">
                  {employees.map((employee) => (
                    <tr key={employee.id} className="hover:bg-slate-50">
                      <td className="px-6 py-4">
                        <p className="font-semibold text-slate-950">
                          {employee.full_name}
                        </p>
                        <p className="mt-1 flex items-center gap-1 text-xs text-slate-500">
                          <Mail size={13} />
                          {employee.email}
                        </p>
                      </td>

                      <td className="px-6 py-4">
                        <span className="inline-flex items-center gap-2 rounded-full bg-slate-100 px-3 py-1 text-xs font-medium text-slate-700">
                          <BriefcaseBusiness size={13} />
                          {employee.job_title}
                        </span>
                      </td>

                      <td className="px-6 py-4 text-sm text-slate-600">
                        <span className="inline-flex items-center gap-1">
                          <MapPin size={14} />
                          {employee.country}
                        </span>
                      </td>

                      <td className="px-6 py-4 text-sm text-slate-600">
                        {employee.department || '-'}
                      </td>

                      <td className="px-6 py-4 text-right font-semibold text-slate-950">
                        ₹{Number(employee.salary).toLocaleString('en-IN')}
                      </td>

                      <td className="px-6 py-4 text-right">
                        <button
                          onClick={() => {
                            setSelectedEmployee(employee)
                            setModalOpen(true)
                          }}
                          className="inline-flex items-center gap-2 rounded-xl border border-slate-200 px-3 py-2 text-xs font-semibold text-slate-700 hover:bg-slate-50"
                        >
                          <Pencil size={14} />
                          Edit
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            <div className="flex items-center justify-between border-t border-slate-200 px-6 py-4">
              <p className="text-sm text-slate-500">
                Page {meta?.current_page || page} of {meta?.total_pages || 1}
              </p>

              <div className="flex gap-2">
                <button
                  disabled={page === 1}
                  onClick={() => setPage((current) => current - 1)}
                  className="rounded-xl border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700 disabled:cursor-not-allowed disabled:opacity-40"
                >
                  Previous
                </button>

                <button
                  disabled={meta && page >= meta.total_pages}
                  onClick={() => setPage((current) => current + 1)}
                  className="rounded-xl border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700 disabled:cursor-not-allowed disabled:opacity-40"
                >
                  Next
                </button>
              </div>
            </div>
          </>
        )}
      </div>

      <EmployeeFormModal
        open={modalOpen}
        employee={selectedEmployee}
        onClose={() => {
          setModalOpen(false)
          setSelectedEmployee(null)
        }}
        onSaved={() => setRefreshKey((current) => current + 1)}
      />
    </div>
  )
}

export default Employees
