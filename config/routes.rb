Rails.application.routes.draw do
  get 'top/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  root 'top#index'
  resources :users, only: %i[new create show edit update]
  resources :account_activations, only: %i[edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :items, only: %i[new create show edit update]
  get 'mypage', to: 'users#show_mypage'
end
