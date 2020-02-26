class BookingsController < ApplicationController
  def new
    @user = current_user
    @surfboard = Surfboard.find(params[:surfboard_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.total_price = (@booking.end_date - @booking.start_date)
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
end
