class Surfboard < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :user, through: :bookings
end
