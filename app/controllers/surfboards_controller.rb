class SurfboardsController < ApplicationController
  before_action :set_surfboard, only: [:edit, :update, :show, :destroy]

  def new
    @surfboard = Surfboard.new
  end

  def create
    @surfboard = Surfboard.new(surfboard_params)
    @surfboard.user = current_user
    @surfboard.save

    redirect_to surfboard_path(@surfboard)
  end

  def index
    @surfboards = Surfboard.all
    @surfboardgeos = Surfboard.geocoded
    @markers = @surfboardgeos.map do |surfboard| {
        lat: surfboard.latitude,
        lng: surfboard.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { surfboard: surfboard })
      }
    end
  end

  def show
    # @markers = { lat: @surfboard.latitude, lng: @surfboard.longitude }
  end

  def update
    @surfboard.update(surfboard_params)
  end

  def edit
  end

  # def destroy
  #   @surfboard.destroy

  #   redirect_to surfboard_path
  # end



  private

    def set_surfboard
      @surfboard = Surfboard.find(params[:id])
    end

    def surfboard_params
      params.require(:surfboard).permit(:title, :brand, :category, :board_dimensions, :location, :price_duration, :price, :deposit, :wave_size, :wave_type, :fin_type, :skill_level, :description, :photo)
    end
end
