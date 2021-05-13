# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static_pages#root'

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[show new create]

  namespace :api do
    defaults format: :json do
      # resources :photos

      resources :todos, only: %i[index show create update destroy]

      # nie ma new - formularz dodawania oraz edit -formularz edycji
      resources :steps, only: %i[index show create update destroy]
      # , defaults: { format: :json }
    end
  end

  # get 'todos/show'
  # get 'todos/index'
  # get 'todos/create'
  # get 'todos/update'
  # get 'todos/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
