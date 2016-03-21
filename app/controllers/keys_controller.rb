class KeysController < ApplicationController
    before_action :require_login
    
    def index
        @allkeys = @session_user.keys.paginate(page: params[:page])
    end
    
    def new 
        @apikey = Key.new
    end
    
    def create
        @apikey = Key.new(apikey_params)
        @apikey.user_id = @session_user.id
        if @apikey.save
            redirect_to keys_path
        else
            render :action => "new"
        end
    end
    
    def destroy
        k = Key.find_by_id(params[:id])
        k.destroy
        flash[:notice] = "Apinyckel borttagen"
        if @session_user.isAdmin
            redirect_to admin_path
        else
            redirect_to keys_path
        end
    end
    
    private
    def apikey_params
        params.require(:key).permit(:application_name, :url)
    end
end
