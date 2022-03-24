Rails.application.routes.draw do
  get 'scrapings/index'
  namespace :api do
    get 'user/index'
  end
  get 'sigin/sigin_out'
  devise_for :users
  get '/', to: 'home#index'
  get 'books/index', to: 'books#index'
  get 'books/detail/:id', to: 'books#detail'
  #get 'pages/index'
  #root to: 'pages#index'
  namespace :api, format: 'json' do
    resources :memos, only: [:index, :create]
    resources :books
    resources :users, only: [:index,:show]
  end
  get '/article/:id', to: 'pages#index'
end