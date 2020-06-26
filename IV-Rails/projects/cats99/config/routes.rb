# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, only: %i[index show create new edit update]
  # resources :cats, except: :destroy

  resources :cat_rental_requests, only: %i[create new] do
    member do
      post 'approve'
      post 'deny'
    end
  end

  resources :users, only: %i[new create show]

  resource :session, only: %i[new create destroy]

  root to: redirect('/cats')
end
