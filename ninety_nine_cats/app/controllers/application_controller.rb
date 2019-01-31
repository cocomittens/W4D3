class ApplicationController < ActionController::Base
  helper_method :current_user, :login!, :logout!, :logged_in?
  
  def current_user
     return nil unless session[:session_token]
     @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    session[:session_token] = nil
    if current_user
      current_user.reset_session_token!
    end
  end

   def logged_in?
    !!current_user
  end
end
