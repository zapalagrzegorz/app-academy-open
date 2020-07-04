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
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login!(@user)

      flash[:success] = 'User successfully signed in'
      redirect_to root_url
    else
      flash.now[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def destroy
    session[:session_token] = nil
    user.reset_session_token!
  end
end
