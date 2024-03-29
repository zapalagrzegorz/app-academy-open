# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_logout, only: %i[new create]
  before_action :require_login, only: :destroy

  def new
    @user = User.new
    render 'new'
  end

  def create
    # verify credentials
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    # set the session

    if @user.nil?
      flash[:alert] = 'Username or password is incorrect'
      render 'new'
    elsif !@user.activated?
      flash.now[:errors] = ['You must activate your account first! Check your email.']
      render :new
    else
      login!(@user)
      flash[:success] = 'You\'ve successfully logged in'
      redirect_to root_url
    end
  end

  def destroy
    if current_user
      # server-side
      current_user.reset_session_token!
      # client-side
      session[:session_token] = ''

      flash[:success] = 'You\'ve successfully logged out'
    end

    redirect_to cats_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
