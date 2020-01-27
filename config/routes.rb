Rails.application.routes.draw do
  resources :users, only: [:show, :new, :edit, :create, :update, :destroy] do
    resources :items, only: [:show, :new, :edit, :create, :update, :destroy], shallow: true
  end
  get 'home/index'
  root to: 'home#index'
end
