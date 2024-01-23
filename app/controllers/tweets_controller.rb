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


# +-------+-------+------------+--------------------+---------------------+---------------------+-------+---------------------+------------+---------------------+---------------------+-------+-------+-------+
# | t0_r0 | t0_r1 | t0_r2      | t0_r3              | t0_r4               | t0_r5               | t1_r0 | t1_r1               | t1_r2      | t1_r3               | t1_r4               | t2_r0 | t2_r1 | t2_r2 |
# +-------+-------+------------+--------------------+---------------------+---------------------+-------+---------------------+------------+---------------------+---------------------+-------+-------+-------+
# |     1 |     1 | あいさつ    | こんにちは           | 2024-01-23 04:58:53 | 2024-01-23 04:58:53 |     1 | kaito@example.com   | $2a$12$WBa | 2024-01-23 04:58:52 | 2024-01-23 04:58:52 |     4 |     1 |     1 |
# |     1 |     1 | あいさつ    | こんにちは           | 2024-01-23 04:58:53 | 2024-01-23 04:58:53 |     1 | kaito@example.com   | $2a$12$WBa | 2024-01-23 04:58:52 | 2024-01-23 04:58:52 |     2 |     2 |     1 |
# |     2 |     2 | 天気       | 今日は晴れです        | 2024-01-23 04:58:53 | 2024-01-23 04:58:53 |     2 | shoichi@example.com | $2a$12$bjH | 2024-01-23 04:58:53 | 2024-01-23 04:58:53 |     1 |     1 |     2 |
# |     3 |     1 | 昼ごはん    | モスバーガーうまい    | 2024-01-23 04:59:58 | 2024-01-23 04:59:58 |     1 | kaito@example.com   | $2a$12$WBa | 2024-01-23 04:58:52 | 2024-01-23 04:58:52 |  NULL |  NULL |  NULL |
# +-------+-------+------------+--------------------+---------------------+---------------------+-------+---------------------+------------+---------------------+---------------------+-------+-------+-------+