Rails.application.routes.draw do
  resources :users, only: [:new, :create, :destroy]
  get ':screen_name', to: 'users#show'
  get '/deactivate', to: 'users#destroy'

  resources :drafts

  get ':screen_name/items/:id', to: 'items#show'
  delete ':screen_name/items/:id', to: 'items#destroy'

  post ':screen_name/items/:item_id/comments', to: 'comments#create', as: :comments
  get ':screen_name/items/:item_id/comments/:id/edit', to: 'comments#edit'
  patch ':screen_name/items/:item_id/comments/:id', to: 'comments#update'
  delete ':screen_name/items/:item_id/comments/:id', to: 'comments#destroy'

  get 'tags/:name', to: 'tags#show'
  root to: 'home#index'
end
