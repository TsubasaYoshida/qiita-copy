Rails.application.routes.draw do
  resources :tags
  resources :drafts
  resources :users, only: [:new, :create, :destroy]
  get 'home/index'
  get ':screen_name', to: 'users#show'
  get ':screen_name/items/:id', to: 'items#show'
  delete ':screen_name/items/:id', to: 'items#destroy'
  get '/deactivate', to: 'users#destroy'
  root to: 'home#index'
end
