module Users
  # Controller for managing favorite lists of users.
  class FavoritesController < ApplicationController
    before_action :check_logged_in, only: %i[index]

    # GET /users/:id/favorites
    def index
      @user = User.find(params[:user_id])
      @tweets = Tweet.eager_load(:user, :favorites).where(favorites: { user_id: @user.id })
    end
  end
end
