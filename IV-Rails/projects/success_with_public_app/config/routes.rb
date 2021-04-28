# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root to: redirect('/')
  root to: 'users#index'

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[index new create show] do
    get 'activate', on: :collection
    # gdybym umieścił tu, to odwołanie do tych zasobów zawsze by się wiązało z
    # id uzytkownika, co jes dosc uciazliwe
    resources :goals, only: %i[new]
  end

  resources :goals, only: %i[show edit create update destroy] do
    # update goals by cheers only via goals page
    resources :cheers, only: [:create]
  end

  # show received cheers of current user
  resources :cheers, only: [:index]

  # zapomniany
  resources :comments, only: [:create]
end
