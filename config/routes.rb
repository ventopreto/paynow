Rails.application.routes.draw do
  devise_for :admins
  root to: "home#index"


  namespace :admin do
    root to: "home#index"
    resources :payment_methods
  end
end
