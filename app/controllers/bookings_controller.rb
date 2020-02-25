class BookingsController < ApplicationController
  def new
    @user = current_user
    @booking = Booking.new
  end

  def create
    raise
    @surfboard = Surfboard.find(params[:surfboard_id])
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.surfboard = @surfboard
    @booking.user = @user
    if @booking.save
      redirect_to user_path(@user)
    else
      render 'booking/new'
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
    params.require(:booking).permit(:start_date, :end_date)
  end
end
