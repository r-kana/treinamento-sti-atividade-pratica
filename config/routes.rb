Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :waypoints, only: [:create, :update, :destroy]
  resources :colleges
  resources :users do 
    resources :rides, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end
  get '/rides/:id/book', to: 'rides#book'
  get '/rides', to: 'rides#search', as: :search_rides
  get '/rides/:id', to: 'rides#show', as: :ride
  get '/login', to: 'authenticate#login', as: :login
end
