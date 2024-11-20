class Airport < ApplicationRecord
  has_many :departing_flights,
           class_name: "Flight",
           inverse_of: :departure_airport

  has_many :arriving_flights,
           class_name: "Flight",
           inverse_of: :arrival_airport

  validates :code, presence: true, uniqueness: true
  validates :city, presence: true
  validates :country, presence: true
  validates :region, presence: true
end
