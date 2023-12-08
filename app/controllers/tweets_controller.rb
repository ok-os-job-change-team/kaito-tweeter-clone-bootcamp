class TweetsController < ApplicationController
  before_action :check_logged_in, only: [:index, :show]

  # GET /tweets
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/:id
  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
  end
end
