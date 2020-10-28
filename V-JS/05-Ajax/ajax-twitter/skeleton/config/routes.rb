# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :feed, only: [:show]
  resource :session, only: %i[create destroy new]
  resources :tweets, only: %i[index create]
  resources :users, only: %i[create new show] do
    get 'search', on: :collection

    resource :follow, only: %i[create destroy]
  end

  root to: redirect('/feed')
end
