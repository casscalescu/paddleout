class Surfboard < ApplicationRecord
  CATEGORY = %w(Shortboard Fish Gun Longboard Foamboard Bodyboard Funboard Other)

  belongs_to :user
  has_many :bookings

  # reverse_geocoded_by :longitude, :latitude, address: :location
  # after_validation :reverse_geocode

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :photo

  validates :brand, presence: true
  validates :price, presence: true, numericality: true
  validates :photo, presence: true
  validates :category, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :deposit, presence: true, numericality: true

  def cat
    CATEGORY
  end

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
