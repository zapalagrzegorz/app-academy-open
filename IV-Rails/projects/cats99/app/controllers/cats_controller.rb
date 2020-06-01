# frozen_string_literal: true

class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else
      # raise
      render :new
      # render json:  @cat
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end
end
