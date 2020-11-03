Rails.application.routes.draw do
  
  devise_for :users
  resources :events
  resources :users, only: [:show]
  root to: "events#index"
end
