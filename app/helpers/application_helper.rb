module ApplicationHelper


    def check_user_bid 
        if current_user
            if current_user.bids.any?
                return true
            end
        end
    end
    
end
