class TweetsController < ApplicationController
  before_action :check_logged_in, only: %i[index show new create]
  before_action -> { check_edit_authority(Tweet.find(params[:id]).user_id) }, only: %i[edit update destroy]

  # GET /tweets
  def index
    @tweets = Tweet.all.eager_load(:user, :favorites)
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

  # GET /tweets/:id/edit
  def edit
    @tweet = current_user.tweets.find(params[:id])
    @user = @tweet.user
  end

  # PUT /tweets/:id
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      flash[:notice] = '修正に成功しました'
      redirect_to tweets_path
    else
      flash.now[:alert] = '修正に失敗しました'
      render :edit
    end
  end

  # DELETE /tweets/:id
  def destroy
    @tweet = current_user.tweets.find(params[:id])
    if @tweet.destroy
      flash[:notice] = '削除に成功しました'
      redirect_to tweets_path
    else
      flash.now[:alert] = '削除に失敗しました'
      render tweets_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :content)
  end
end