# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :require_user!

  def show
    # model.includes(user: [:band]).find(params[:id])
    @goal = Goal.includes(:user).find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = Goal.includes(:user).find(params[:id])
  end

  def create
    # debugger
    @goal = current_user.goals.new(goal_params)
    # @goal = Goal.new(goal_params)
    if @goal.save
      flash[:success] = 'Goal successfully created'
      redirect_to @goal
    else
      # @user = User.find(@user_id)
      # debugger
      # @users = User.where(band_id: @user.band_id)
      # flash.now[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    # current_user
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
    redirect_to user
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details, :private, :completed)
  end
end
