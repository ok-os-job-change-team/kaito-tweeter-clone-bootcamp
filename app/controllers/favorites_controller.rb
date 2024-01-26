class FavoritesController < ApplicationController
  before_action :check_logged_in, only: %i[create destroy]

  # POST /tweets/:tweet_id
  def create
    favorite = current_user.favorites.build(tweet_id: params[:tweet_id])
    if favorite.save
      flash[:notice] = 'いいね登録に成功しました'
      redirect_to tweets_path
    else
      flash.now[:alert] = 'いいね登録に失敗しました'
      render tweets_path
    end
  end

  # DELETE /tweets/:tweet_id
  def destroy
    favorite = Favorite.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    if favorite.destroy
      flash[:notice] = 'いいね解除に成功しました'
      redirect_to tweets_path
    else
      flash.now[:alert] = 'いいね解除に失敗しました'
      render tweets_path
    end
  end
end
