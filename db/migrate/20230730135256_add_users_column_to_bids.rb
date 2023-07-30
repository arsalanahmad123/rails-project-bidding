class AddUsersColumnToBids < ActiveRecord::Migration[7.0]
  def change
    add_column :bids, :user_id, :integer
  end
end
