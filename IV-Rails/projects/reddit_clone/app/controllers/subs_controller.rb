# frozen_string_literal: true

class SubsController < ApplicationController
  before_action :require_user!, except: :index
  before_action :require_moderator, only: %i[edit update destroy]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.includes(:moderator).find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def create
    # @sub = current_user.subs.new(sub_params)
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    # debugger
    if @sub.save
      flash[:success] = 'Sub successfully created'
      redirect_to @sub
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      flash[:success] = 'Sub was successfully updated'
      redirect_to @sub
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub.destroy
      flash[:success] = 'sub was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_moderator
    #     return if current_user.subs.find_by(id: params[:id])
    sub = Sub.find(params[:id])
    return if sub.moderator_id == current_user.id

    flash[:error] = 'You\'re not allowed to do this'
    # render json: 'Forbidden', status: :forbidden
    redirect_to root_url
  end
end
