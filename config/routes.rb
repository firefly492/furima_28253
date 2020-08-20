Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items do
    resources :buyers, only: [:index, :new, :create]
  end
end
