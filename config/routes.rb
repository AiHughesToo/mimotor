Rails.application.routes.draw do
  resources :jobs
  resources :stats
   devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #login
  post 'user/login' => 'authentication#create'

  #users
  post 'user' => 'users#create'

  #jobs
  post 'make/job' => 'jobs#create'
  post 'rider_job_list' => 'jobs#local_jobs_list_rider'
  put  'take/job/:id' => 'jobs#take_job'
  put  'rider/complete/:id' => 'jobs#rider_complete'
  get  'check_open/job' => 'jobs#check_open_jobs'
end
