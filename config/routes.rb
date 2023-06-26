Rails.application.routes.draw do
  devise_for :users
  root to: "hikes#index"
  resources :locations, only: [:index]
  resources :hikes do
    resources :locations, only: [:new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
