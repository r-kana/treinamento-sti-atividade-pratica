Rails.application.routes.draw do
  resources :waypoints
  resources :rides
  get 'authenticate/login'
  resources :users
  resources :colleges
end
