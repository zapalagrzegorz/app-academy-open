# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @session = Session.new
    render 'new'
  end

  def create
    # verify credentials
    @user = User.find_by_credentials(session_params)

    # set the session

    if @user
      login!(@user)
      flash[:success] = 'You\'ve successfully logged in'
      redirect_to @user
    else
      flash[:error] = 'Username or password is incorrect'
      render 'new'
    end
  end

  def destroy
    @session = Session.find(params[:id])
    if @session.destroy
      flash[:success] = 'You\'ve successfully logged out'
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to cats_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
