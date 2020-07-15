# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: %i[index show new create]

  resource :session, only: %i[new create destroy]

  # resources vs resource?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
