Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  
  root to: 'tasks#index'
  resources :tasks
end
