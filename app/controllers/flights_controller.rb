class FlightsController < ApplicationController
  def index
    @airports = Airport.all.select(:id, :code)
    @flights = Flight.includes(:arrival_airport, :departure_airport)
                     .where(flight_params)
                     .order("departure_airport.city", :departure_datetime)
    set_view_filters
  end

  private

  def set_view_filters
    # Sets some sensible defaults, but allows them to be overridden
    # Persists the filters across requests, so that the user inputs in
    # the form are preserved and the form doesn't reset on each request
    @filters ||= {
      departure_airport_id: search_params[:departure_airport_id],
      arrival_airport_id: search_params[:arrival_airport_id],
      passenger_count: search_params[:passenger_count] || 1,
      departure_date: search_params[:departure_date] || Date.tomorrow
    }
  end

  def search_params
    @search_params ||= params.permit(:departure_airport_id, :arrival_airport_id, :passenger_count, :departure_date)
  end

  def flight_params
    # converts date into datetime range and filters out empty params before passing to `Flight.where()`` query
    {
      departure_airport_id: search_params[:departure_airport_id],
      arrival_airport_id: search_params[:arrival_airport_id],
      departure_datetime: datetime_range_from(search_params[:departure_date])
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
