class TweetsController < ApplicationController
  before_action :check_logged_in, only: [:index, :show]

  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
  end
end
