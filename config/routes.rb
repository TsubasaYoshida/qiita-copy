Rails.application.routes.draw do
  # drafts
  resources :drafts, only: %i(index new edit create update destroy)

  # login
  resource :session, only: %i(new create destroy)

  # users
  get 'signup', to: 'users#new'
  get ':screen_name', to: 'users#show', as: :user
  post 'registration', to: 'users#create', as: :users
  delete 'deactivate', to: 'users#destroy'

  namespace :settings do
    resource :profile, only: %i(edit update)
    resource :password, only: %i(edit update)
  end

  # items
  get ':screen_name/items/:id', to: 'items#show'
  delete ':screen_name/items/:id', to: 'items#destroy', as: :item_destroy

  # comments
  post ':screen_name/items/:draft_id/comments', to: 'comments#create', as: :comments
  get ':screen_name/items/:draft_id/comments/:id/edit', to: 'comments#edit', as: :comment_edit
  patch ':screen_name/items/:draft_id/comments/:id', to: 'comments#update', as: :comment_update
  delete ':screen_name/items/:draft_id/comments/:id', to: 'comments#destroy', as: :comment_destroy

  # tags
  get 'tags/:name', to: 'tags#show', as: :tag

  # likes
  post ':screen_name/items/:draft_id/likes', to: 'likes#create', as: :likes
  delete ':screen_name/items/:draft_id/likes/:id', to: 'likes#destroy', as: :like_destroy

  # root
  root to: 'home#index'
end
