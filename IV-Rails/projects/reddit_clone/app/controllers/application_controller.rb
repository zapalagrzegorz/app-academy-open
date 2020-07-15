# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  # set user and session to the same token
  def login!(user)
    # @user = User.find_by(email: email)
    session[:session_token] = user.reset_session_token!
    # session_token if @user.password == password
  end

  def logout; end

  # checks session against users' session tokens
  def current_user
    return nil if session[:session_token].nil?

    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
