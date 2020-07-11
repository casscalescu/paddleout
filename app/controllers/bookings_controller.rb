class BookingsController < ApplicationController
  before_action :find_surfboard, only: [:new, :create]
  before_action :find_booking, only: [:update]
  before_action :authenticate_user!

  def new
    @user = current_user
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.status = "Pending"
    @booking.total_price = calculate_total_price(@booking) if @booking.valid?
    if @booking.save
      redirect_to bookings_path
    else
      @surfboard = @booking.surfboard
      render 'bookings/new'
    end
  end

  def show
    @user = current_user
    @booking = Booking.find(params[:id])
  end

  def index
    @bookings = Booking.all
  end

  def update
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  private

  def find_surfboard
    @surfboard = Surfboard.find(params[:surfboard_id])
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def calculate_total_price(booking)
    surfboard = booking.surfboard
    ((booking.end_date - booking.start_date) * surfboard.price).round(2)
  end
end
