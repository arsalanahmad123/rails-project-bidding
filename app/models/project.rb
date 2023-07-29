class Project < ApplicationRecord 
  belongs_to :user
  has_one_attached :image
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
end
