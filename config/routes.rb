Rails.application.routes.draw do
  root to: 'welcome#index', as: :welcome
  resources :waypoints, only: [:create, :update, :destroy]
  resources :colleges
  resources :users, except: [:destroy] do 
    resources :rides
  end
  get '/home', to: "welcome#home", as: :home

  get '/rides/:id/book', to: 'rides#book', as: :book_ride
  get '/rides', to: 'rides#search', as: :search_rides
  get '/rides/:id', to: 'rides#search_show', as: :search_ride
  post '/login', to: 'authenticate#login', as: :login
  get '/logout', to: 'authenticate#logout', as: :logout
  get '/users/:id/toggle_active', to: 'users#toggle_active', as: :toggle_active
end
