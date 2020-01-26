Rails.application.routes.draw do
  get 'home/index'
  resources :users, only: [:show, :new, :edit, :create, :update, :destroy]
  root to: 'home#index'
end
