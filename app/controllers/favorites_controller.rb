class FavoritesController < ApplicationController
  before_action :check_logged_in, only: %i[create destroy]

  # POST /tweets/:tweet_id
  def create
    favorite = current_user.favorites.build(tweet_id: params[:tweet_id])
    favorite.save
    redirect_to tweets_path
  end

  # DELETE /tweets/:tweet_id
  def destroy
    favorite = Favorite.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    favorite.destroy
    redirect_to tweets_path
  end
end
