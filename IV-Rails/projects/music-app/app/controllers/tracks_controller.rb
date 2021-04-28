# frozen_string_literal: true

class TracksController < ApplicationController
  before_action :require_user!

  def new
    @track = Track.new
    @album_id = params[:id]
    @album = Album.find(@album_id)
    # debugger
    @albums = Album.where(band_id: @album.band_id)
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = 'Track successfully created'
      redirect_to @track
    else
      @album = Album.find(@album_id)
      # debugger
      @albums = Album.where(band_id: @album.band_id)
      # flash.now[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def show
    @note = Note.new
    @track = Track.includes(album: [:band]).find(params[:id])
    @notes = @track.notes
  end

  def edit
    @track = Track.includes(:album).find(params[:id])
    @album_id = params[:id]
    @album = @track.album
    @albums = Album.where(band_id: @album.band_id)
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      flash[:success] = 'Track was successfully updated'
      redirect_to @track
    else
      render 'edit'
    end
  end

  def destroy
    @track = Track.includes(:album).find(params[:id])
    album = @track.album
    if @track.destroy
      flash[:success] = 'Track was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to band_url(album)
  end

  private

  def track_params
    params.require(:track).permit(:title, :ord, :regular, :lyrics, :album_id)
  end
end
