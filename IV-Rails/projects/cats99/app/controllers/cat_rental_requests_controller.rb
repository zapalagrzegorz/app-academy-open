# frozen_string_literal: true

class CatRentalRequestsController < ApplicationController
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      # flash[:success] = "CatRentalRequest successfully created"
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      # flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def new
    @cats = Cats.all
    @cat_rental_request = CatRentalRequest.new
    render 'new'
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date)
  end
end
