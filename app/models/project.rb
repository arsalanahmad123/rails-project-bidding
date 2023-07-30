class Project < ApplicationRecord 
  belongs_to :user 
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :url, presence: true


  has_many :bids, dependent: :destroy


  def add_bid(bid)
    if self.bids.empty?
      self.bid = bid.amount
    else 
      if self.bids.last.amount < bid.amount
        self.bid = bid.amount
      end
    end
  end

end
