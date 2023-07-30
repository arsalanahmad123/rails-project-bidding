class Bid < ApplicationRecord
  belongs_to :project
  validates :amount,presence: true
  belongs_to :user
end
