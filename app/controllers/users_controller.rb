class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    User.create(user_params)
    redirect_to '/users'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
    # require(:user)はuser内に指定の値が存在するかチェック
    # permit(:email, :password)はemailとpasswordがあるかチェック
    # つまり、user内にemailとpasswordがあるかどうかを確認している
  end
end


