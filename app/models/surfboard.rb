class Surfboard < ApplicationRecord
  # collections for validation and user input
  CATEGORY = %w(Shortboard Longboard Funboard Hybrid Other)
  PRICE_DURATION = %w(Hour Day Week)
  SKILL_LEVEL = %w(Beginner Intermediate Advanced Expert)
  WAVE_SIZE = %w(1-3 4-6 7-10 10+)
  WAVE_TYPE = %w(Reef Pointbreak Beachbreak)
  FIN_TYPE = ['Single-fin', 'Twin', 'Tri/thruster', 'Quad', 'Other']
  
  # associations
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings

  # validations
  validates :brand, presence: true
  validates :price, presence: true, numericality: true
  validates :photo, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :title, presence: true
  validates :price_duration, presence: true, inclusion: { in: PRICE_DURATION }
  validates :description, presence: true
  validates :wave_type, presence: true, inclusion: { in: WAVE_TYPE }
  validates :board_dimensions, presence: true
  validates :fin_type, presence: true, inclusion: { in: FIN_TYPE}
  validates :deposit, presence: true, numericality: true
  validates :skill_level, presence: true, inclusion: { in: SKILL_LEVEL }
  validates :wave_size, presence: true, inclusion: { in: WAVE_SIZE }
  validates :location, presence: true
end