# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :require_user!

  def new
    @user = User.find(params[:user_id])
    @goal = @user.goals.new
    # @user_id = params[:user_id]
    # @goal = Goal.new
    # debugger
    # @users = User.where(band_id: @user.band_id)
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      flash[:success] = 'Goal successfully created'
      redirect_to @goal
    else
      @user = User.find(@user_id)
      # debugger
      @users = User.where(band_id: @user.band_id)
      # flash.now[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def show
    @note = Note.new
    @goal = Goal.includes(user: [:band]).find(params[:id])
    @notes = @goal.notes
  end

  def edit
    @goal = Goal.includes(:user).find(params[:id])
    @user_id = params[:id]
    @user = @goal.user
    @users = User.where(band_id: @user.band_id)
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      flash[:success] = 'Goal was successfully updated'
      redirect_to @goal
    else
      render 'edit'
    end
  end

  def destroy
    @goal = Goal.includes(:user).find(params[:id])
    user = @goal.user
    if @goal.destroy
      flash[:success] = 'Goal was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to band_url(user)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :ord, :regular, :lyrics, :user_id)
  end
end
