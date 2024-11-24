class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Flight.find(flight_id).bookings.new
    passenger_count.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      PassengerMailer.with(
        booking: @booking,
        passenger: @booking.passengers.first
      ).confirmation_email.deliver_now

      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [ [ :name, :email ] ])
  end

    def flight_id
      @flight_id ||= booking_params[:flight_id]
    end

  def passenger_count
    @passenger_count ||= params[:booking][:passenger_count].to_i
  end
end
