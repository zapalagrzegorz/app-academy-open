# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  # set user and session to the same token
  def login!(user)
    # @user = User.find_by(email: email)
    session[:session_token] = user.reset_session_token!
    # debugger
    # session_token if @user.password == password
  end

  def logout; end

  # checks session against users' session tokens
  def current_user
    # debugger
    return nil if session[:session_token].nil?

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_user!
    if current_user.nil?
      flash[:alert] = 'You must be signed in to access this section'
      redirect_to new_session_path
    end
  end

  # nie wiem czemu to są private metody w kontrolerze
  # private

  # def signed_in?
  #   !!current_user
  # end

  # def sign_in(user)
  #   @current_user = user
  #   session[:token] = user.reset_session_token!
  # end

  # def sign_out
  #   current_user.try(:reset_session_token!)
  #   session[:token] = nil
  # end

  # def require_signed_in!
  #   redirect_to new_session_url unless signed_in?
  # end

  # def require_signed_out!
  #   redirect_to subs_url if signed_in?
  # end
end
