Rails.application.routes.draw do
  root to: 'welcome#index', as: :welcome
  resources :waypoints, only: [:create, :update, :destroy]
  resources :colleges, except: [:destroy, :show]
  resources :users, except: [:destroy] do 
    resources :rides
  end
  get '/home', to: "welcome#home", as: :home

  get '/rides/:id/book', to: 'rides#book', as: :book_ride
  get '/rides', to: 'rides#search', as: :search_rides
  get '/rides/:id', to: 'rides#search_show', as: :search_ride
  post '/login', to: 'authenticate#login', as: :login
  get '/logout', to: 'authenticate#logout', as: :logout
  get '/users/:id/toggle_active', to: 'users#toggle_active', as: :user_toggle_active
  get '/colleges/:id/toggle_active', to: 'colleges#toggle_active', as: :college_toggle_active
  get 'user/:user_id/rides/:id/toggle_active', to: 'rides#toggle_active', as: :ride_toggle_active
  get '/ride/:ride_id/add_stops', to: 'waypoints#add_stops', as: :add_stops
  post 'ride/:ride_id/create_stops', to: 'waypoints#create_stops', as: :create_stops
  
end
