Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  #resources :users, only: [:destroy]
end
