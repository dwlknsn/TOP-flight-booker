class PassengerMailer < ApplicationMailer
  def confirmation_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    @flight = @booking.flight
    @url = "http://localhost:3000/bookings"
    mail(to: @passenger.email, subject: "Flight Confirmation")
  end
end
