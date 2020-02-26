class BookingsController < ApplicationController
  def new
    @user = current_user
    @surfboard = Surfboard.find(params[:surfboard_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.total_price = calculate_total_price(@booking)
    if @booking.save
      redirect_to bookings_path
    else
      render 'bookings/new'
    end
  end

  def show
    @user = current_user
    @booking = Booking.find(params[:id])
  end

  def index
    @bookings = Booking.all
    @user = current_user
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :surfboard_id)
  end

  def calculate_total_price(booking)
    surfboard = booking.surfboard
    price = case surfboard.price_duration
            when 'Week' then (((booking.end_date - booking.start_date) / 604_800) * surfboard.price).round(2)
            when 'Day' then (((booking.end_date - booking.start_date) / 86_400) * surfboard.price).round(2)
            when 'Hour' then (((booking.end_date - booking.start_date) / 3600) * surfboard.price).round(2)
            end
    price
  end
end
