Rails.application.routes.draw do
  get 'home', to: 'home#index'
  get 'books/index', to: 'books#index'
  get 'books/detail/:id', to: 'books#detail'
  #get 'pages/index'
  #root to: 'pages#index'
  namespace :api, format: 'json' do
    resources :memos, only: [:index, :create]
    resources :books, only: [:index, :create]
    resources :users, only: [:index]
  end
  # Routerのmodeがhashの場合は不要です
  get '/article/:id', to: 'pages#index'
end