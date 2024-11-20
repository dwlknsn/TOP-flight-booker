class Flight < ApplicationRecord
  belongs_to :departure_airport,
             class_name: "Airport",
             foreign_key: :departure_airport_id,
             inverse_of: :departing_flights
  belongs_to :arrival_airport,
             class_name: "Airport",
             foreign_key: :arrival_airport_id,
             inverse_of: :arriving_flights
  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings

  validates :departure_datetime, presence: true
  validates :duration_minutes, presence: true

  def flight_details
    <<~HEREDOC
      From #{departure_airport.city}, #{departure_airport.country} (#{departure_airport.code})
      To #{arrival_airport.city}, #{arrival_airport.country} (#{arrival_airport.code})
      Departing at #{departure_datetime} (#{duration_minutes} minutes)
    HEREDOC
  end
end
