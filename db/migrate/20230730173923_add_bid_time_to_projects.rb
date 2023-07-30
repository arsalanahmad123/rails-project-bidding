class AddBidTimeToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :bid_time, :datetime
  end
end
