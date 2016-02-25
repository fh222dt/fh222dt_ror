class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end
  
  def require_login
    if current_user.nil? then
      redirect_to root_path
    end
  end
  
end
