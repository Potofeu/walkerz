Rails.application.routes.draw do
  devise_for :users
  root to: "hikes#index"
  resources :favorites, only: [:index, :destroy]
  resources :points_of_interest, only: [:update]
  resources :achievements, only: :index

  resources :hikes do
    resources :favorites, only: [:new, :create]
    resources :reviews, only: :create
    resources :locations, only: [:new, :create]
    resources :hikes_categories, only: [:update]
    resources :achievements, only: :create
  end

  resources :reviews, only: :destroy

  resources :my_hikes, only: [:index, :show]
  resources :hikes, only: [:update, :edit, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
