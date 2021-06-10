Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :admins, path: 'admins'
  root to: "home#index"


  namespace :user do
    resources :companies, only: %i[new create show]
  end

  namespace :admin do
    root to: "home#index"
    resources :payment_methods
    resources :companies, only: %i[index show edit update] do
      patch 'update_token', on: :member
    end
  end
end
