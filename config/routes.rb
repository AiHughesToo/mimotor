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
  post 'request_pass_reset' => 'users#password_reset'

  #jobs
  post 'make/job' => 'jobs#create'
end
