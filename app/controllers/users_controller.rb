class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]
	def edit
	end

	def update
		@user.update(user_params)
		redirect_to edit_user_path(@user)
	end

	def show
	end

	# def destroy
	# 	@user.destroy
	# 	redirect_to root_path
	# end

	private

	def set_user
    	@user = User.find(params[:id])
  	end

	def user_params
		params.require(:user).permit(:description, :photo)
	end
end
