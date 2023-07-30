class BidsController < ApplicationController 
    before_action :set_project, only: [:new, :create]
    before_action :require_user!, only: [:new, :create]

    def new 
        @bid = Bid.new
    end

    def create 
        @bid = @project.bids.build(bid_params)
        @bid.user_id = current_user.id 
        @project.add_bid(@bid)
        respond_to do |format|
        if @bid.save
           format.turbo_stream {
            render turbo_stream: turbo_stream.replace("bid-form", partial: "bids/success")
           }
           format.html { redirect_to project_path(@project) }
        else
            format.html { render :new, status: :unprocessable_entity }
        end
    end
    end



    private 

        def set_project 
            @project = Project.find(params[:project_id])
        end

        def bid_params
            params.require(:bid).permit(:amount)
        end

end