Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :admins, path: 'admins'
  root to: "home#index"


  namespace :admin do
    root to: "home#index"
    resources :payment_methods
  end
end
