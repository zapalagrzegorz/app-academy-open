# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'users', to: 'users#index'
  # post 'users', to: 'users#create'

  # get 'users/new', to: 'users#new', as: 'new_user'

  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  resources :users, only: %i[index create show update destroy] do
    member do
      resources :artworks, only: [:index]
      get 'favourites', to: "user#favourite"
      get 'comments', to: 'comments#user_comments'
    end
  end

  resources :comments, only: %i[create destroy]

  resources :artworks, only: %i[create destroy show update] do
    member do
      get 'comments', to: 'comments#artwork_comments'
      post 'favourite', to: 'artworks#favourite'
      post 'unfavourite', to: 'artworks#unfavourite'
      post :like, to: 'artworks#like', as: 'like'
      post :dislike, to: 'artworks#dislike', as: 'dislike'
    end
  end


  resources :artwork_shares, only: %i[create destroy] do
    member do
      post 'favourite', to: 'artwork_shares#favourite'
      post 'unfavourite', to: 'artwork_shares#unfavourite'
    end
  end

  resources :comments, only: %i[index]
end
