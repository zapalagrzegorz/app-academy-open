# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # make it available from views
  helper_method :current_user
  #   helper_method :logged_in?

  # ?
  private

  def login!(user)
    @current_user = user

    session[:session_token] = user.reset_session_token!
  end

  def current_user
    return nil if session[:session_token].nil?

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  # def require_no_user!
  #   redirect_to cats_url if current_user
  # end

  def require_logout
    return unless current_user

    flash[:alert] = 'You must be logged out to access this section'
    redirect_to root_url # halts request cycle
  end

  def require_login
    return if current_user

    flash[:alert] = 'You must be logged in to access this section'
    redirect_to new_session_url # halts request cycle
  end

  # def require_user!
  #   redirect_to new_session_url if current_user.nil?
  # end

  # def logged_in?
  #   !current_user.nil?
  # end
end
