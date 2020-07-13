class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	def edit
	end

	def update
		@user.update(user_params)
		redirect_to user_path(@user)
	end

	def show
	end

	private

	def set_user
  	@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:description, :photo, :username)
	end
end
