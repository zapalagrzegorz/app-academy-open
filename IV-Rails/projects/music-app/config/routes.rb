# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/bands')

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create show] do
    get 'activate', on: :collection
  end

  resources :bands do
    # member do
    resources :albums, only: :new
    # end
  end

  resources :albums, except: %i[index new] do
    member do
      resources :tracks, only: :new
    end
  end

  resources :tracks, except: %i[index new] do
    # zbędny ten create tutaj, tylko dla new robi się ścieżkę
    # new_band_album
    # new_album_track
    # a note nie ma osobnej ścieżki, bo jest osadzona na stronie track
    # bez member powstanie ścieżka track_notes
    # a z member dalej mamy ścieżkę notes
    member do
      resources :notes, only: :create
    end
  end

  resources :notes, only: :destroy

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
