Rails.application.routes.draw do
  
  devise_for :users

  resources :events do
    resources :attendances, only: [:new, :create, :index]
    
  end
  resources :users, only: [:show, :edit,:update, :create] do
    resources :photos, only: [:create]
  end
 
  
  root to: "events#index"
end
