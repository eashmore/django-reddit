Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :session, only: [:new, :create, :destroy]
end
