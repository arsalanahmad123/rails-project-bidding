class User < ApplicationRecord
    has_secure_password 
    validates :phone, phone: true 
    validates :password, presence: true, confirmation: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    has_many :projects 
    enum role: [:buyer,:seller,:admin]
    has_many :bids, dependent: :destroy
end
