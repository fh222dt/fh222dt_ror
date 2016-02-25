class UsersController < ApplicationController
    
    def index
    end
        
    def new 
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:userid] = @user.id
            redirect_to keys_path
        else
            render :action => "new"
        end
    end
    
    def destroy
        
    end
    
    ##Inloggningsmetoder
    
    def login
        u = User.find_by_email(params[:email])
        if u && u.authenticate(params[:password]) && u.isAdmin ==true
            session[:userid] = u.id
            redirect_to admin_path
        elsif u && u.authenticate(params[:password])
            session[:userid] = u.id
            redirect_to keys_path
        else
           flash[:notice] = "Pröva igen!"
           redirect_to root_path
        end
    end
    
    def logout
        session[:userid] = nil
        redirect_to root_path, :notice => "Utloggad"
        
    end
    
    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
    
end
