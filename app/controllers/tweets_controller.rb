class TweetsController < ApplicationController
  before_action :check_logged_in, only: [:index, :show]

  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
  end

  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_logged_in
    redirect_to login_path if current_user.nil?
  end
end
