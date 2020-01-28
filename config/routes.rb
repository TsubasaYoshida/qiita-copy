Rails.application.routes.draw do
  resources :users, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :items, only: [:show, :new, :edit, :create, :update, :destroy]
  get 'home/index'
  root to: 'home#index'
end
