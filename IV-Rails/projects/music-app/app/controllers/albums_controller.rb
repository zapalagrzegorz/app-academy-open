# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :require_user!

  def show
    @album = Album.includes(:band).find(params[:id])
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = 'Album successfully created'
      redirect_to @album
    else
      @bands = Band.all
      render :new
    end
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      flash[:success] = 'Album was successfully updated'
      redirect_to @album
    else
      @bands = Band.all
      render :edit
    end
  end

  def destroy
    album = Album.includes(:band).find(params[:id])
    if album.destroy
      flash[:success] = 'Album was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to band_url(album.band)
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :studio, :band_id)
  end
end
