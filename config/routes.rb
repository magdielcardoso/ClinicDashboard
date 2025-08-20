Rails.application.routes.draw do
  root "dashboard#index"

  resources :appointments
  resources :procedures
  resources :clients
  devise_for :users
end
