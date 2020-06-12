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
    # duplication
    cat_request = CatRentalRequest.find(params[:id])
    cat_request.approve!
    redirect_to cat_url(cat_request.cat)
  end

  def deny
    cat_request = CatRentalRequest.find(params[:id])
    # CatRentalRequest belongs_to cat, a więc zapytanie do bazy
    # dla obiektu "właściciela" jest  generowane  dopiero
    # na żądanie, chyba, że poprosisz o dane wcześniej

    #   #     CatRentalRequest.includes(:cat).find(params[:id])
    #
    cat_request.deny!
    # aby cat_request.cat nie robił kolejnego zapytania
    # trzeba zrobić .includes(:cat), aby zaciągnął od razu obiekt
    redirect_to cat_url(cat_request.cat)
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

  # private

  # def current_cat_rental_request
  #   @rental_request ||=
  #     CatRentalRequest.includes(:cat).find(params[:id])
  # end

  # def current_cat
  #   current_cat_rental_request.cat
  # end

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end
end
