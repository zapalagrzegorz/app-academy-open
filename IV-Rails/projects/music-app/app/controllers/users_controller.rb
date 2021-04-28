# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save

      msg = UsersMailer.activate_email(@user)
      msg.deliver_now
      flash[:success] = '<h1 class="black h2 text-center">User was successfully created.</h1>
      <p class="h3 text-center">You need to confirm your email before login.</p>'
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
