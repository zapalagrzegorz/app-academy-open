class ApplicationController < ActionController::Base
  # helper method będzie dostępna także dla widoku
  helper_method :current_user

  # Ustawaia sesję serwera set user and session to the same token
  def login!(user)
    # @user = User.find_by(email: email)
    session[:session_token] = user.reset_session_token!
    # debugger
    # session_token if @user.password == password
  end

  # checks server session against users' session tokens
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
end
