# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bands do
    member do
      resources :albums, only: :new
    end
  end

  resources :albums, except: %i[index new]

  resources :users, only: %i[new create show]

  resource :session, only: %i[new create destroy]

  root to: redirect('/bands')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
