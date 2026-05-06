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
