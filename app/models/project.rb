class Project < ApplicationRecord 
  belongs_to :user 
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :url, presence: true
  validates :bid_time, presence: true
  validate :bid_time_cannot_be_in_the_past
  has_many :bids, dependent: :destroy
  before_validation :set_default_bid_time, on: :create

  def add_bid(bid)
    if self.bids.empty?
      self.bid = bid.amount
    else 
      if self.bids.last.amount < bid.amount
        self.bid = bid.amount
      end
    end
  end

  def validate_bid_time 
    self.bid_time >= DateTime.now
  end

  def bid_time_cannot_be_in_the_past
    if bid_time.present? && bid_time < Time.now
      errors.add(:bid_time, "cannot be in the past")
    end
  end

  def set_default_bid_time
    self.bid_time ||= Time.now + 12.hours
  end

  def display_datetime 
    self.bid_time.strftime("%b %d, %Y at %l:%M %p")
  end


end
