# frozen_string_literal: true

class CatRentalRequestsController < ApplicationController
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      # flash[:success] = "CatRentalRequest successfully created"
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      # flash[:error] = "Something went wrong"
      @cats = Cat.all
      render :new
    end
  end

  def new
    # debugger
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def approve
    cat_request = CatRentalRequest.find(params[:id])
    cat_request.approve!
    redirect_to cat_url(cat_request.cat)
  end

  def deny
    cat_request = CatRentalRequest.find(params[:id])
    cat_request.deny!
    redirect_to cat_url(cat_request.cat)
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end
