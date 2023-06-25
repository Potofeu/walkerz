Rails.application.routes.draw do
  devise_for :users
  root to: "hikes#index"
  resources :hikes
  resources :locations, only: [:new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
