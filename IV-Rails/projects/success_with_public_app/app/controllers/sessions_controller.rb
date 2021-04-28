# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_user!, only: :destroy
  before_action :require_no_user!, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_user_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user.nil?
      flash[:alert] = 'Username or password is incorrect'
      render 'new'
    elsif !@user.activated?
      flash.now[:alert] = 'You must activate your account first! Check your email. <br> Check server console log for a link in email or run mailcatcher
        Open http://127.0.0.1:1080/ in the browser'
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
    flash[:success] = '<h1 class="black">User successfully signed out</h1>'
    redirect_to new_session_path
  end
end
