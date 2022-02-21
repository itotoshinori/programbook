Rails.application.routes.draw do
  get 'home', to: 'home#index'
  get 'books', to: 'books#index'
  #get 'pages/index'
  #root to: 'pages#index'
  namespace :api, format: 'json' do
    resources :memos, only: [:index, :create]
    resources :books, only: [:index, :create]
  end
  # Routerのmodeがhashの場合は不要です
  get '/article/:id', to: 'pages#index'
end