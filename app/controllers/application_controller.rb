class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_cache_buster
  
  include Knock::Authenticable
  
  #check if user whant offset/limit
  OFFSET = 0
  LIMIT = 20
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end
  
  
   def session_user
     @session_user ||= User.find(session[:userid]) if session[:userid]
   end
  
  def require_login
    if session_user.nil? then
      redirect_to root_path
    end
  end
  
  
  protected
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  #TODO ta bort för att nyckeldelen ska funka
  
  # def default_format_json
  #   if((request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?))
  #     request.format ="json"
  #   end
  # end
  
  def api_key
    if
     Key.find_by(key: params[:api_key])
    else
      render json: { error: "Ogiltig apinyckel" }, status: :unauthorized
    end
  end
  
end
