Rails.application.routes.draw do
  devise_for :users
  root to: "hikes#index"

  resources :favorites, only: [:index]

  resources :hikes do
    resources :favorites, only: [:new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
