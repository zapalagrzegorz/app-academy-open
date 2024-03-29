# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    # fetches the user we've logged in as
    return nil if session[:session_token].nil?

    User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    # force other clients to log out by regenerating token
    user.reset_session_token!
    # log this client in
    session[:session_token] = user.session_token
  end

  def log_out!
    session[:session_token] = nil
  end

  def require_logged_in!
    redirect_to new_session_url if current_user.nil?
  end

  # gdy jest zalogowany przekieruj na feed
  def require_not_logged_in!
    redirect_to feed_url unless current_user.nil?
    # current_user.nil? - true - nie jest zalogowany
    # current_user.nil? - false - gdy jest zalogowany
  end
end
