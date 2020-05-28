# frozen_string_literal: true

class ArtworksController < ApplicationController
  def index
    user_id = params[:id]
    user = User.find_by(id: user_id)
    if user
      render json: Artwork.artworks_for_user_id(user_id)
    else
      render json: user.errors.full_messages, status: :not_found
    end
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save
      render json: artwork, status: :created
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    artwork = Artwork.find_by(id: params[:id])

    if artwork
      render json: artwork
    else
      render plain: 'Not found', status: :not_found
    end
    # render json: Artwork.find(params[:id])
  end

  def update
    artwork = Artwork.find(params[:id])
    if artwork.update_attributes(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :not_found
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    if artwork.destroy
      render json: artwork
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def like
    if !params[:user_id] || !params[:id]
      render plain: 'Not found', status: :not_found
      return
    end

    like = Like.new(user_id: params[:user_id], likeable_type: 'Artwork', likeable_id: params[:id])
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
    # artwork.update(favourite: true)
  end

  def dislike
    render plain: 'Not found', status: :not_found unless params.require(:user_id, :id)

    like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')
    if like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def favourite
    if params.require(:id)
      Artwork
        .find(params[:id])
        .update(favourite: true)
      render json: Artwork.find(params[:id])
    end
  end

  def unfavourite
    if params.require(:id)
      Artwork
        .find(params[:id])
        .update(favourite: false)
      render json: Artwork.find(params[:id])
    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
