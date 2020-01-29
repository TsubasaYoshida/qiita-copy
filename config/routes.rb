Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :destroy]
  resources :items, only: [:show, :new, :edit, :create, :update, :destroy]
  get 'home/index'
  get '/deactivate', to: 'users#destroy'
  root to: 'home#index'
end
