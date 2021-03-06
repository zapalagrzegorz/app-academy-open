# frozen_string_literal: true

include ERB::Util

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(:goals).find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save

      msg = UserMailer.activate_email(@user)
      msg.deliver_now
      flash[:success] = "<h1 class='black h2 text-center'>User: #{h(@user.email)} was successfully created.</h1>
      <p class='h3 text-center'>You need to confirm your email before login.</p>
      <p>You must activate your account first! Check your email. <br> Run mailcatcher
      Open http://127.0.0.1:1080/ in the browser</p>"
      redirect_to new_session_path
    else
      render :new
    end
  end

  def activate
    user = User.find_by(activation_token: params[:activation_token])
    if user.nil? || user.activated
      render plain: 'Invalid token'
      return
    end
    user.toggle!(:activated)
    login!(user)
    flash[:success] = 'Your account has been activated'
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
