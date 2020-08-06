Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items, only: [:create, :edit, :index, :new, :show]
  resources :transactions, only: [:index, :new, :crete]
end
