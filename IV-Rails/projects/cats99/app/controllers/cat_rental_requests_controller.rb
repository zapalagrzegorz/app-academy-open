# frozen_string_literal: true

class CatRentalRequestsController < ApplicationController
  before_action :require_login
  before_action :require_login_by_owner, only: %i[approve deny]

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    @cat_id = params[:id] if params[:id]
    # debugger
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.user_id = current_user.id

    if @cat_rental_request.save
      flash[:success] = 'Cat rental request successfully created'
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @cats = Cat.all
      render :new
    end
  end

  def approve
    # duplication
    # ponieważ dwa razy masz CatRentalRequest.includes(:cat).find(params[:id]) to można to wyłączyć
    # do osobnej metody np, currentCatRentalRequest
    # cat_request = CatRentalRequest.includes(:cat).find(params[:id])

    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat_rental_request.cat)
  end

  def deny
    # CatRentalRequest belongs_to cat, a więc zapytanie do bazy
    # dla obiektu "właściciela" jest  generowane  dopiero
    # na żądanie, chyba, że poprosisz o dane wcześniej

    #   #     CatRentalRequest.includes(:cat).find(params[:id])
    #
    current_cat_rental_request.deny!
    # aby cat_request.cat nie robił kolejnego zapytania
    # trzeba zrobić .includes(:cat), aby zaciągnął od razu obiekt
    redirect_to cat_url(current_cat_rental_request.cat)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def require_login_by_owner
    # owner has
    unless current_user.id == current_cat.user_id
      flash[:error] = 'You are not permitted to that site'
      redirect_to root_url
    end
  end
end
