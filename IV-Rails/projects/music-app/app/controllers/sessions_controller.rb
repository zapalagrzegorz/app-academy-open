# frozen_string_literal: true

class SessionsController < ApplicationController
  #   before_action :require_logout, only: %i[new create]
  # before_action :require_login, only: :destroy
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
    if @user
      login!(@user)

      flash[:success] = '<h1 class="black">User successfully signed in</h1>'
      redirect_to root_url
    else
      @user = User.new(email: params[:user][:email])
      flash.now[:alert] = 'Email or password is incorrect'
      render 'new'
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    flash[:success] = '<h1 class="black">User successfully signed out</h1>'
    redirect_to new_session_path
  end
end
