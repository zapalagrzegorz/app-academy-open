class SessionsController < ApplicationController
  # formularz logowania
  def new
    @user = User.new
  end

  # obsługa żądania sesji logowania
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
      redirect_to root_url
    end
  end

  # obsługa zakończenia sesji
  # korzysta helpera kontrola current_user
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to root_url
  end
end
