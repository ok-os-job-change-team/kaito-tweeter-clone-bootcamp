class TweetsController < ApplicationController
  before_action :check_logged_in, only: [:index, :show, :new, :create]

  # GET /tweets
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/:id
  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))
    if @tweet.save
      flash[:notice] = '投稿に成功しました'
      redirect_to tweets_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :content)
  end
end
