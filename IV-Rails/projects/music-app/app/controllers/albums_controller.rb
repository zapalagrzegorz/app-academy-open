# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :require_user!

  def new
    @album = Album.new
    @bands = Band.all
    @band_id = params[:id].to_i
    render :new
  end

  def create
    # debugger
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = 'Album successfully created'
      redirect_to @album
    else
      # flash.now[:error] = 'Something went wrong'
      @bands = Band.all
      render 'new'
    end
  end

  def show
    @album = Album.includes(:band).find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      flash[:success] = 'Album was successfully updated'
      redirect_to @album
    else
      @bands = Band.all
      # flash.now[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @album = Album.includes(:band).find(params[:id])
    band = @album.band
    if @album.destroy
      flash[:success] = 'Album was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to band_url(band)
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :studio, :band_id)
  end
end
