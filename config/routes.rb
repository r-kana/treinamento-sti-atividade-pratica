Rails.application.routes.draw do
  root to: 'welcome#index', as: :index
  resources :waypoints, only: [:create, :update, :destroy]
  resources :colleges
  resources :users do 
    resources :rides
  end

  get '/rides/:id/book', to: 'rides#book', as: :book_ride
  get '/rides', to: 'rides#search', as: :search_rides
  get '/rides/:id', to: 'rides#search_show', as: :search_ride
  post '/login', to: 'authenticate#login', as: :login
  get '/home', to: "welcome#home", as: :home
end
