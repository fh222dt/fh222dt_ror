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
  
  
  protected
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  before_action :default_format_json
  def default_format_json
    if((request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?))
      request.format ="json"
    end
  end
  
end
