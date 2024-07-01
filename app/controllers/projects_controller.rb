class ProjectsController < ApplicationController 
    before_action :require_admin!,only: [:destroy_expired_bids]
    before_action :require_user!, except: %i[index show] 
    before_action :set_project , only: [:show,:destroy]
    before_action :check_user_role, only: [:new, :create]

    def index
        @projects = Project.all 
    end 

    def show 
        @bids = @project.bids.order("amount DESC")
    end

    def new 
        @project = Project.new 
    end

    def create 
        @project = Project.new(project_params)
        @project.user = current_user
        if @project.save 
            flash[:success] = "Project was successfully created"
            redirect_to project_path(@project)
        else
            flash.now[:danger] = @project.errors.full_messages.to_sentence
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy_expired_bids
        projects = Project.where('bid_time <= ?', DateTime.now)
        project_ids = projects.pluck(:id)
        BidsJob.perform_at(1.minute.from_now,project_ids)
    end

    def destroy 
        @project.destroy
        flash[:success] = "Project was successfully deleted"
        redirect_to projects_path
    end



    private 

        def project_params
            params.require(:project).permit(:title, :description, :url,:bid_time)
        end

        def set_project
            @project = Project.find(params[:id])
        end

        def check_user_role
            if !current_user.seller?
                flash[:danger] = "You are not authorized to perform that action"
                redirect_to root_path
            end
        end

        def require_admin!
            if !current_user.admin?
                flash[:danger] = "You are not authorized to perform that action"
                redirect_to root_path
            end
        end

end