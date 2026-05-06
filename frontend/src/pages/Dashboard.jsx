import { Users, TrendingUp, Landmark, BadgeDollarSign } from 'lucide-react'

const cards = [
  {
    title: 'Total Employees',
    value: '10,000',
    icon: Users,
    description: 'Active employee records'
  },
  {
    title: 'Average Salary',
    value: '₹82,400',
    icon: BadgeDollarSign,
    description: 'Across selected country'
  },
  {
    title: 'Highest Salary',
    value: '₹2,00,000',
    icon: TrendingUp,
    description: 'Top salary package'
  },
  {
    title: 'Countries',
    value: '5',
    icon: Landmark,
    description: 'Global salary coverage'
  }
]

function Dashboard() {
  return (
    <div className="space-y-6">
      <div className="rounded-3xl bg-slate-950 p-8 text-white shadow-xl">
        <p className="text-sm font-medium text-slate-300">
          Welcome back
        </p>

        <h1 className="mt-2 text-3xl font-bold">
          Manage employee salaries with clear insights
        </h1>

        <p className="mt-3 max-w-2xl text-sm leading-6 text-slate-300">
          Track employee records, country-wise salary metrics, and job-title based compensation insights from one clean HR dashboard.
        </p>
      </div>

      <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-4">
        {cards.map((card) => {
          const Icon = card.icon

          return (
            <div
              key={card.title}
              className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm"
            >
              <div className="flex items-center justify-between">
                <div className="rounded-2xl bg-slate-100 p-3 text-slate-900">
                  <Icon size={22} />
                </div>
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
    </div>
  )
}

export default Dashboard
