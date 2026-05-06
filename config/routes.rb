Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :employees

      get 'salary_insights/country',
        to: 'salary_insights#country'

      get 'salary_insights/job_title',
        to: 'salary_insights#job_title'

      get 'salary_insights/distribution',
        to: 'salary_insights#distribution'
    end
  end
end
