class Favorite::FavoritesController < ApplicationController
	# GET /users/:id/favorites
	def index
		# binding.pry
		@user = User.find(params[:user_id])
		@tweets = Tweet.eager_load(:user, :favorites).where(favorites: { user_id: @user.id })
	end
end