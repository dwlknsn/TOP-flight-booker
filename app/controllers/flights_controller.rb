class FlightsController < ApplicationController
  def index
    @airports = Airport.all.select(:code, :id)
    @flights = Flight.where(search_params).order(:departure_airport_id, :departure_datetime)
  end

  private

  def search_params
    filters = params.permit(search: [ :departure_airport_id, :arrival_airport_id, :passenger_count, :departure_date ])
    {
      departure_airport_id: filters[:search][:departure_airport_id],
      arrival_airport_id: filters[:search][:arrival_airport_id],
      departure_datetime: datetime_range_from(filters[:search][:departure_date])
    }.select { |_, v| v.present? }
  end

  def datetime_range_from(date)
    date = if date.present?
      Date.parse(date)
    else
      Date.tomorrow
    end

    [ date.beginning_of_day, Time.now ].max..date.end_of_day
  end
end
