import { useState } from 'react'
import { X, Loader2 } from 'lucide-react'
import { createEmployee } from '../api/employees'

const initialForm = {
  full_name: '',
  email: '',
  job_title: '',
  country: '',
  department: '',
  salary: '',
  joining_date: '',
}

function EmployeeFormModal({ open, onClose, onCreated }) {
  const [form, setForm] = useState(initialForm)
  const [saving, setSaving] = useState(false)
  const [errors, setErrors] = useState([])

  if (!open) return null

  const handleChange = (event) => {
    const { name, value } = event.target

    setForm((current) => ({
      ...current,
      [name]: value,
    }))
  }

  const handleSubmit = async (event) => {
    event.preventDefault()

    try {
      setSaving(true)
      setErrors([])

      await createEmployee(form)

      setForm(initialForm)
      onCreated()
      onClose()
    } catch (error) {
      setErrors(
        error.response?.data?.errors || ['Something went wrong. Please try again.']
      )
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/50 p-4 backdrop-blur-sm">
      <div className="w-full max-w-2xl rounded-3xl bg-white shadow-2xl">
        <div className="flex items-center justify-between border-b border-slate-200 px-6 py-5">
          <div>
            <h2 className="text-xl font-bold text-slate-950">
              Add Employee
            </h2>
            <p className="mt-1 text-sm text-slate-500">
              Create a new employee salary record.
            </p>
          </div>

          <button
            onClick={onClose}
            className="rounded-xl p-2 text-slate-500 hover:bg-slate-100"
          >
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-5 p-6">
          {errors.length > 0 && (
            <div className="rounded-2xl border border-red-200 bg-red-50 p-4">
              {errors.map((error) => (
                <p key={error} className="text-sm font-medium text-red-700">
                  {error}
                </p>
              ))}
            </div>
          )}

          <div className="grid gap-4 md:grid-cols-2">
            <input
              name="full_name"
              value={form.full_name}
              onChange={handleChange}
              placeholder="Full name"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />

            <input
              name="email"
              value={form.email}
              onChange={handleChange}
              placeholder="Email"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />

            <input
              name="job_title"
              value={form.job_title}
              onChange={handleChange}
              placeholder="Job title"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />

            <input
              name="country"
              value={form.country}
              onChange={handleChange}
              placeholder="Country"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />

            <input
              name="department"
              value={form.department}
              onChange={handleChange}
              placeholder="Department"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />

            <input
              name="salary"
              value={form.salary}
              onChange={handleChange}
              placeholder="Salary"
              type="number"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />

            <input
              name="joining_date"
              value={form.joining_date}
              onChange={handleChange}
              type="date"
              className="rounded-2xl border border-slate-200 px-4 py-3 text-sm outline-none focus:border-slate-900"
            />
          </div>

          <div className="flex justify-end gap-3 pt-2">
            <button
              type="button"
              onClick={onClose}
              className="rounded-2xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-700 hover:bg-slate-50"
            >
              Cancel
            </button>

            <button
              disabled={saving}
              className="inline-flex items-center gap-2 rounded-2xl bg-slate-950 px-5 py-3 text-sm font-semibold text-white hover:bg-slate-800 disabled:opacity-60"
            >
              {saving && <Loader2 className="animate-spin" size={16} />}
              Save Employee
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}

export default EmployeeFormModal
