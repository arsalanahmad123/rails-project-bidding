class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.decimal :amount
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
