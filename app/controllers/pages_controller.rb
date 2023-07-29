class PagesController < ApplicationController
  before_action :restrict_user!
  
  def index
  end



  private 

    def restrict_user!
      if current_user
        redirect_to projects_path
      end
    end
end
