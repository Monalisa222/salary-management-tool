import apiClient from './client'

export async function fetchCountrySalaryInsights(country) {
  const response = await apiClient.get('/salary_insights/country', {
    params: { country },
  })

  return response.data
}

export async function fetchJobTitleSalaryInsights(country, jobTitle) {
  const response = await apiClient.get('/salary_insights/job_title', {
    params: {
      country,
      job_title: jobTitle,
    },
  })

  return response.data
}

export async function fetchSalaryDistribution(country) {
  const response = await apiClient.get('/salary_insights/distribution', {
    params: { country },
  })

  return response.data
}
