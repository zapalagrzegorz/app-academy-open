# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_logout

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(user)
      flash[:success] = 'User successfully created'
      redirect_to @user
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def require_logout
    unless current_user
      flash[:error] = 'You must be logged out in to access this section'
      redirect_to cats_url # halts request cycle
    end
  end
end
