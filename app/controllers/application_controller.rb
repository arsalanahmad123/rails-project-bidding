class ApplicationController < ActionController::Base

    helper_method :current_user,:login,:logout,:require_user!


    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def login(user)
        session[:user_id] = user.id
    end

    def logout 
        session[:user_id] = nil
    end

    def require_user!
        if !current_user
            flash[:danger] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end
end
