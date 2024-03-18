class Admin::TweetsController < ApplicationController
  before_action :check_admin

  # GET /admin/tweets
  def index
    @tweets = Tweet.all.preload(:user, :favorites)
  end

  # DELETE admin/tweets/:id
  def destroy
    @tweet = Tweet.find(params[:id])
    # @tweet = current_user.tweets.find(params[:id])
    if @tweet.destroy
      flash[:notice] = '削除に成功しました'
      redirect_to admin_tweets_path
    else
      flash.now[:alert] = '削除に失敗しました'
      render admin_tweets_path
    end
  end
end
