Rails.application.routes.draw do
  get 'authenticate/login'
  resources :users
  resources :colleges
end
