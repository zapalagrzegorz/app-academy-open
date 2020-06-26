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
      UserMailer.welcome_email(@user).deliver_now

      login!(@user)
      flash[:success] = 'User successfully created.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  # def show
  #   @user = current_user
  # end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
