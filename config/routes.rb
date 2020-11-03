Rails.application.routes.draw do
  
  devise_for :users
  resources :events
  resources :users, only: [:show, :edit,:update]
  root to: "events#index"
end
