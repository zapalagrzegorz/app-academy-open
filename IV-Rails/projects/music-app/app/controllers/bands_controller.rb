# frozen_string_literal: true

class BandsController < ApplicationController
  before_action :require_user!

  def index
    @bands = Band.all
  end

  def show
    @band = Band.includes(:albums).find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(bands_param)
    if @band.save
      flash[:success] = 'Band successfully created'
      redirect_to @band
    else
      flash[:error] = 'Something went wrong'
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(bands_param)
      flash[:success] = 'Band was successfully updated'
      redirect_to @band
    else
      flash[:error] = 'Something went wrong'
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.destroy
      flash[:success] = 'Band was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to bands_url
  end

  private

  def bands_param
    params.require(:band).permit(:name)
  end
end
