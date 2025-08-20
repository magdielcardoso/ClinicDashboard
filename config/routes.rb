Rails.application.routes.draw do
  root "dashboard#index"

  get "calendar", to: "dashboard#calendar"

  resources :appointments
  resources :procedures
  resources :clients
  devise_for :users
end
