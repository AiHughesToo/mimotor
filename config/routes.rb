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

  #password
  post 'reset_password' => 'users#reset_password'
  post 'set_pass' =>'password#set_new_password'

  #jobs
  post 'make/job' => 'jobs#create'
  post 'rider_job_list' => 'jobs#local_jobs_list_rider'
  put  'take/job/:id' => 'jobs#take_job'
  put  'job/complete/:id' => 'jobs#job_complete'
  put  'job/cancel/:id' => 'jobs#job_cancel'
  get  'check_open/job' => 'jobs#check_open_jobs'
  get  'job/:id' => 'jobs#show'
end
