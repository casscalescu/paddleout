class SurfboardsController < ApplicationController
  before_action :set_surfboard, only: [:edit, :update, :show, :destroy]

  def new
    @surfboard = Surfboard.new
  end

  def create
    #need to set user id
    Surfboard.create(surfboard_params)
  end

  def index
    @surfboards = Surfboard.all
  end

  def show
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
      params.require(:surfboard).permit(:title, :brand, :category, :board_dimensions, :price_duration, :price, :deposit, :wave_size, :wave_type, :fin_type, :skill_level, :description, :photo)
    end
end
