Rails.application.routes.draw do
  # drafts
  resources :drafts

  # login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # users
  get '/signup', to: 'users#new'
  get ':screen_name', to: 'users#show', as: :user
  post '/registration', to: 'users#create', as: :users
  get '/deactivate', to: 'users#destroy'

  get 'settings/profile', to: 'users#profile'
  put 'settings/profile', to: 'users#profile_update'

  get 'settings/password', to: 'users#password'
  put 'settings/password', to: 'users#password_update'

  # get 'settings/password/reset', to: 'users#password_reset_send_mail'
  # get 'settings/password/new', to: 'users#password_reset_new'
  # post 'settings/password', to: 'users#password_reset_update'

  # items
  get ':screen_name/items/:id', to: 'items#show'
  delete ':screen_name/items/:id', to: 'items#destroy', as: :item_destroy

  # comments
  post ':screen_name/items/:item_id/comments', to: 'comments#create', as: :comments
  get ':screen_name/items/:item_id/comments/:id/edit', to: 'comments#edit', as: :comment_edit
  patch ':screen_name/items/:item_id/comments/:id', to: 'comments#update', as: :comment_update
  delete ':screen_name/items/:item_id/comments/:id', to: 'comments#destroy', as: :comment_destroy

  # tags
  get 'tags/:name', to: 'tags#show', as: :tag

  # likes
  post ':screen_name/items/:draft_id/likes', to: 'likes#create', as: :likes
  delete ':screen_name/items/:draft_id/likes/:id', to: 'likes#destroy', as: :like_destroy

  # root
  root to: 'home#index'
end
