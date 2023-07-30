class ProjectsController < ApplicationController 
    include ActiveStorage::SetCurrent
    before_action :require_user!, except: %i[index show] 
    before_action :set_project , only: [:show, :edit, :update, :destroy]

    def index
        @projects = Project.all 
    end 

    def show 
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



    private 

        def project_params
            params.require(:project).permit(:title, :description, :url)
        end

        def set_project
            @project = Project.find(params[:id])
        end

end