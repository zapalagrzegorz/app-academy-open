# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      flash[:success] = 'user was successfully created.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
