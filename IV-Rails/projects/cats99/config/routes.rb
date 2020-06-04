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

  root to: redirect('/cats')
end
