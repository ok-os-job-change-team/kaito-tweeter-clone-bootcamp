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
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '登録に成功しました'
      redirect_to '/users'
    else
      flash.now[:alret] = '登録に失敗しました'
      render :new
      # redirect_to ('/users/new'), flash: {alret: '登録に失敗しました'}
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
    # require(:user)はuser内に指定の値が存在するかチェック
    # permit(:email, :password)はemailとpasswordがあるかチェック
    # つまり、user内にemailとpasswordがあるかどうかを確認している
  end
end


