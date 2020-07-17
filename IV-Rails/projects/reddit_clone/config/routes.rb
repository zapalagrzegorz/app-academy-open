# frozen_string_literal: true

Rails.application.routes.draw do
  root 'subs#index'

  resources :users, only: %i[index show new create]

  resource :session, only: %i[new create destroy]

  resources :subs

  resources :posts, except: :index

  # resources vs resource?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
