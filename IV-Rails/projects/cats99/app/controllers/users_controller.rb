# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User successfully created'
      login!(user)
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
end
