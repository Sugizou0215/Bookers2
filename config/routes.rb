Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
end
