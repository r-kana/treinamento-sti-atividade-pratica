Rails.application.routes.draw do
  resources :waypoints, only: [:create, :update, :destroy]
  resources :colleges
  resources :users do 
    resources :rides, only: [ :index, :create, :update, :destroy ]
  
  get '/rides', to: 'rides#search', as: :search_rides
  get '/rides/:id', to: 'rides#show', as: :ride
  get '/login', to: 'authenticate#login', as: :login
end
