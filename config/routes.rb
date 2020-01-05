Rails.application.routes.draw do
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  namespace :admin do
    resources :users
  end
  
  root to: 'tasks#index'
  resources :tasks do
    post '/confirm', action: :confirm_new, on: :new
  end
end
