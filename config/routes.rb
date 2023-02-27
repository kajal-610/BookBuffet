Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get 'gallery/index'
  resources :stores
  get 'home/index'
  root 'home#index'
  devise_for :users
  get 'admin/login'
  post 'admin/login'
  get 'admin/logout'
  get 'gallery/checkout'
  post 'gallery/checkout'
  get 'gallery/purchase'
  get 'gallery/search'
  post 'gallery/search'
end
