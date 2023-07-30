class SessionsController < ApplicationController
    before_action :check_user, only: [:new, :create]

    def new 

    end

    def create 
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password]) 
            login(@user)
            flash[:success] = "You have successfully logged in"
            redirect_to projects_path
        else 
            flash[:danger] = "Invalid email/password"
            redirect_to login_path
        end
    end

    def destroy 
        logout
        flash.now[:notice] = "You have successfully logged out"
        redirect_to root_path
    end

    private 
    def check_user
        if current_user
            flash.now[:notice] = "You are already logged in"
            redirect_to root_path
        end
    end
end
