# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root to: redirect('/')
  root to: 'users#show'

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[index new create show] do
    get 'activate', on: :collection
    resources :goals, only: %i[show new edit create update delete]
  end
end
