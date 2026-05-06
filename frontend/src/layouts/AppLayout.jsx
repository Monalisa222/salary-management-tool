import { BarChart3, Users, WalletCards } from 'lucide-react'

function AppLayout({ children }) {
  return (
    <div className="min-h-screen bg-slate-50">
      <aside className="fixed left-0 top-0 hidden h-screen w-72 border-r border-slate-200 bg-white px-6 py-6 lg:block">
        <div className="mb-10">
          <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-slate-900 text-white shadow-lg">
            <WalletCards size={24} />
          </div>

          <h1 className="mt-4 text-xl font-bold text-slate-950">
            SalaryHub
          </h1>

          <p className="mt-1 text-sm text-slate-500">
            HR salary management dashboard
          </p>
        </div>

        <nav className="space-y-2">
          <a className="flex items-center gap-3 rounded-2xl bg-slate-900 px-4 py-3 text-sm font-medium text-white shadow-sm">
            <BarChart3 size={18} />
            Dashboard
          </a>

          <a className="flex items-center gap-3 rounded-2xl px-4 py-3 text-sm font-medium text-slate-600 hover:bg-slate-100">
            <Users size={18} />
            Employees
          </a>
        </nav>
      </aside>

      <main className="lg:pl-72">
        <header className="sticky top-0 z-10 border-b border-slate-200 bg-white/80 px-6 py-4 backdrop-blur">
          <div>
            <p className="text-sm font-medium text-slate-500">
              HR Manager Workspace
            </p>
            <h2 className="text-2xl font-bold text-slate-950">
              Salary Management
            </h2>
          </div>
        </header>

        <section className="p-6">
          {children}
        </section>
      </main>
    </div>
  )
}

export default AppLayout
