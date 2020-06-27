class BandsController < ApplicationController

  def index
    @bands = Bands.all
    render :index
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(params[:band])
    if @band.save
      flash[:success] = "Band successfully created"
      redirect_to @band
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
      if @band.update_attributes(params[:band])
        flash[:success] = "Band was successfully updated"
        redirect_to @band
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end
  
  def show
    @band = Band.find(id)
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.destroy
      flash[:success] = 'Band was successfully deleted.'
      redirect_to bands_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to bands_url
    end
  end
  
  
  

  
    
  end


end
