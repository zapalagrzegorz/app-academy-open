# frozen_string_literal: true

class CatsController < ApplicationController
  before_action :require_login, only: %i[create new edit update]
  before_action :require_login_owner, only: %i[edit update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(cat_rental_requests: [:requester]).find(params[:id])
    # @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    # debugger
    @cat = current_user.cats.new(cat_params)

    # przyjmuje tylko jeden zestaw parametrów
    # @cat = Cat.new(cat_params, user_id: current_user.id)

    if @cat.save
      flash[:success] = "Cat '#{cat_params[:name]}' has been successfuly created"
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    # @cat = Cat.find(params[:id])
    @cat = current_user.cats.find_by(id: params[:id])
    if @cat.blank?
      flash[:alert] = 'We\'re sorry, you are not permitted to that site'
      redirect_to root_url
    else
      render :edit

    end
  end

  def update
    @cat = current_user.cats.find(params[:id])

    if @cat.update_attributes(cat_params)
      flash[:success] = 'Cat was successfully updated'
      redirect_to cat_url(@cat)
    else
      render 'edit'
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end

  def require_login_owner
    # debugger
  end
end
