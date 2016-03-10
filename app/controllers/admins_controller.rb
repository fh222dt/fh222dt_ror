class AdminsController < ApplicationController
    before_action :require_login
    
    def index
        if @current_user.isAdmin 
            @apikeys = Key.joins(:user).paginate(page: params[:page])
        else
            redirect_to keys_path
        end
        
    end
end
