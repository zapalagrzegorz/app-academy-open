# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static_pages#root'

  namespace :api do
    defaults format: :json do
      # resources :photos

      resources :todos, only: %i[index show create update destroy]
      # , defaults: { format: :json }
    end
    # get 'todos/show'
    # get 'todos/index'
    # get 'todos/create'
    # get 'todos/update'
    # get 'todos/destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
