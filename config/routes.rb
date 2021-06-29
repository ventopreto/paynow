Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :admins, path: 'admins'
  root to: "home#index"
  resources :receipts, only: %i[show], param: :authorization_code

  namespace :api do
    namespace :v1 do
      resources :end_users, only: %i[create]
      resources :charges, only: %i[index create]
      end
    end

  namespace :user do
    resources :payment_methods do
      resources :boletos, except: %i[destroy put]
      resources :pixes, except: %i[destroy put]
      resources :credit_cards, except: %i[destroy put]
    end
    resources :companies, only: %i[new create show], param: :token do  
      resources :chosen_payments, only: %i[index]
      resources :products, except: %i[destroy put]
      resources :charges, only: %i[index edit update], param: :token
      patch 'update_token', on: :member
    end

  end

  namespace :admin do
    root to: "home#index"
    resources :payment_methods
    resources :companies, only: %i[index show edit update] do
      patch 'update_token', on: :member
    end
  end
end
