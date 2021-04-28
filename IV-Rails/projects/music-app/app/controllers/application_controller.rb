# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  # also :current_user_id, :logged_in?

  def login!(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    return nil if session[:session_token].nil?

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_user!
    if current_user.nil?
      flash[:alert] = 'You must be signed in to access this section'
      redirect_to new_session_path
    end
  end

  def require_no_user!
    if current_user

      flash[:alert] = 'You must be signed out to access this section'
      redirect_to root_url
    end
  end

  def is_logged_in?
    !current_user.nil?
  end
end
