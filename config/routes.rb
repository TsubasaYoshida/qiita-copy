Rails.application.routes.draw do
  resources :likes
  # users
  resources :users, only: [:new, :create, :destroy]
  get ':screen_name', to: 'users#show'
  get '/deactivate', to: 'users#destroy'

  # drafts
  resources :drafts

  # items
  get ':screen_name/items/:id', to: 'items#show'
  delete ':screen_name/items/:id', to: 'items#destroy'

  # comments
  post ':screen_name/items/:item_id/comments', to: 'comments#create', as: :comments
  get ':screen_name/items/:item_id/comments/:id/edit', to: 'comments#edit', as: :comment_edit
  patch ':screen_name/items/:item_id/comments/:id', to: 'comments#update', as: :comment_update
  delete ':screen_name/items/:item_id/comments/:id', to: 'comments#destroy', as: :comment_destroy

  # tags
  get 'tags/:name', to: 'tags#show'

  # root
  root to: 'home#index'
end
