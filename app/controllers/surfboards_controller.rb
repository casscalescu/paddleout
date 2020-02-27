class SurfboardsController < ApplicationController
  before_action :set_surfboard, only: %i[edit update show destroy]

  def new
    @surfboard = Surfboard.new
    @user = current_user
  end

  def create
    @surfboard = Surfboard.new(surfboard_params)
    @surfboard.user = current_user
    @surfboard.save

    redirect_to surfboard_path(@surfboard)
  end

  def index
    if params[:query].present?
      # @surfboards = Surfboard.where("location ILIKE ?", "%#{params[:query]}%")
      @surfboards = Surfboard.near(params[:query], 10, units: :km)
    else
      @surfboards = Surfboard.all
    end
    @markers = @surfboards.map do |surfboard| 
      {
        lat: surfboard.latitude,
        lng: surfboard.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { surfboard: surfboard }) }
    end
    # @surfboardgeos = @surfboards.geocoded
  end

  def show
    # @markers = { lat: @surfboard.latitude, lng: @surfboard.longitude }
  end

  def update
    @surfboard.update(surfboard_params)
    redirect_to surfboard_path
  end

  def edit
    @user = current_user
  end

  def destroy
    if @surfboard.bookings.nil?
      @surfboard.destroy
      @message = 'Your surfboard has been deleted.'
    else
      @message = 'You can not delete this surfboard because it has been booked.'
    end
  end

  private

  def set_surfboard
    @surfboard = Surfboard.find(params[:id])
  end

  def surfboard_params
    params.require(:surfboard).permit(:title, :brand, :category, :board_dimensions, :location, :price_duration, :price, :deposit, :wave_size, :wave_type, :fin_type, :skill_level, :description, :photo)
  end
end
