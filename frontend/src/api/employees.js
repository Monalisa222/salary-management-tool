import apiClient from './client'

export async function fetchEmployees(page = 1, perPage = 10) {
  const response = await apiClient.get('/employees', {
    params: {
      page,
      per_page: perPage,
    },
  })

  return response.data
}

export async function createEmployee(employee) {
  const response = await apiClient.post('/employees', {
    employee,
  })

  return response.data
}

export async function updateEmployee(id, employee) {
  const response = await apiClient.patch(`/employees/${id}`, {
    employee,
  })

  return response.data
}
