class SurfboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_surfboard, only: %i[edit update show destroy]

  def new
    @surfboard = Surfboard.new
  end

  def create
    @surfboard = Surfboard.new(surfboard_params)
    @surfboard.user = current_user
    if @surfboard.save
      redirect_to surfboard_path(@surfboard)
    else
      render :new
    end
  end

  def index
    if params[:query].present?
      @surfboards = Surfboard.near(params[:query], 5, units: :km)
      @surfboards = Surfboard.all if @surfboards.empty?
    else
      @surfboards = Surfboard.all
    end
    @markers = @surfboards.map do |surfboard|
      {
        lat: surfboard.latitude,
        lng: surfboard.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { surfboard: surfboard }) }
    end
  end

  def show
    @user = @surfboard.user
    @booking = Booking.new
    # raise
  end

  def update
    if @surfboard.update(surfboard_params)
      redirect_to surfboard_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def destroy
    if @surfboard.bookings.count.zero?
      @surfboard.destroy
      @message = 'Your surfboard has been deleted.'
    else
      @message = 'You can not delete this surfboard because it has been booked.'
    end
  end

  private

  def find_surfboard
    @surfboard = Surfboard.find(params[:id])
  end

  def surfboard_params
    params.require(:surfboard).permit(:name, :brand, :category, :location, :price, :deposit, :description, :photo)
  end
end
