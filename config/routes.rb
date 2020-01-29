Rails.application.routes.draw do
  resources :users, only: [:new, :create, :destroy]
  resources :items, only: [:show, :new, :edit, :create, :update, :destroy]
  get 'home/index'
  get ':screen_name', to: 'users#show'
  get '/deactivate', to: 'users#destroy'
  root to: 'home#index'
end
