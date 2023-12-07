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

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    # ログイン機能がマージされていないので、仮にuser_id = 1 を代入してツイートを作成
    @tweet.user_id = 1
    # ログイン機能がマージされた後、以下を実装する
    # @tweet.user_id = current_user.id
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
      binding.pry
      params.require(:tweet).permit(:tweet_content)
    end
end
