Rails.application.routes.draw do
  get 'top/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  root 'top#index'
  # resources :users, only: %i[new create show edit update]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: %i[edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :items, only: %i[new create show edit update]
  resources :relationships, only: [:create, :destroy]
  get 'mypage', to: 'users#show_mypage'

  namespace :api, { format: 'json' } do
    resources :relationships, only: %i[index create destroy]
  end
end


# constraints: 動的セグメントのURLフォーマットを特定の形式に制限
## 例: get '/articles/:id' , to: 'articles#show', constraints: { id: /[A-Z]\d{5}/ }
## match => /articles/A11111, not_match => /articles/111

# asオプションをつけると、名前を指定することができる
## 例: get 'exit', to: 'sessions#destroy', as: :logout
## 名前付きヘルパーとしてlogout_pathとlogout_urlが作成

# 指定方法
## scope:  URL: 指定のパスにしたい	ファイル構成: 変えたくない
## namespace  URL: 指定のパスにしたい	ファイル構成: 指定のパスにしたい
## module  URL: 変えたくない	ファイル構成: 指定のパスにしたい