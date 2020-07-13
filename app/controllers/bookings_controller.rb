class BookingsController < ApplicationController
  before_action :find_booking, only: [:show]
  before_action :find_surfboard, only: [:new]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.total_price = calculate_total_price(@booking) if @booking.valid?
    if @booking.save
      redirect_to user_path(current_user)
    else
      @surfboard = @booking.surfboard
      render 'bookings/new'
    end
  end

  def show
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_surfboard
    @surfboard = Surfboard.find(params[:surfboard_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :surfboard_id)
  end

  def calculate_total_price(booking)
    surfboard = booking.surfboard
    ((booking.end_date - booking.start_date) * surfboard.price).round(2)
  end
end
