class UsersController < ApplicationController
    def new 
        @user = User.new 
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            login(@user)
            redirect_to root_path
            flash[:success] = "User created successfully"
        else 
            flash.now[:danger] = @user.errors.full_messages
            render :new
        end
    end

    def destroy 
        @user = User.find(params[:id])
        logout
        @user.destroy
        redirect_to root_path, notice: "User has been deleted"
    end

    private 

        def user_params
            params.require(:user).permit(:username,:email,:phone,:password,:password_confirmation,:role)
        end

end
