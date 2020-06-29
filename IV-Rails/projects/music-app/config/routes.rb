# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create show]

  resources :bands do
    member do
      resources :albums, only: :new
    end
  end

  resources :albums, except: %i[index new] do
    member do
      resources :tracks, only: :new
    end
  end

  resources :tracks, except: %i[index new]

  root to: redirect('/bands')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
