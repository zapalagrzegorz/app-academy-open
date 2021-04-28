# frozen_string_literal: true

class UsersController < ApplicationController
  # index, show, new, edit, create, , update, destroy

  #   before_action :require_signed_in!, only: [:show]
  # before_action :require_signed_out!, only: [:new, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #    sign_in(@user)
      login!(@user)
      flash[:success] = 'User successfully created'
      redirect_to user_url(@user)
    else
      flash[:alert] = 'Email or password is incorrect'
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
