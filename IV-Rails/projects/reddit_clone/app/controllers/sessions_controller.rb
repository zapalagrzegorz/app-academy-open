# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  # create the session
  # find user
  # set session (cookie) and user matching data

  def create
    @user = User.find_user_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user.nil?
      flash[:alert] = 'Username or password is incorrect'
      render :new
    else
      login!(@user)
      flash[:success] = "#{@user.email}, you\'ve successfully logged in"
      redirect_to user_url(@user.id)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to root_url
  end
end
