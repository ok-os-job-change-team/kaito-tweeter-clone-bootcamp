class UsersController < ApplicationController
  before_action :check_logged_in, only: [:index, :show]
  before_action :check_edit_authority, only:[:edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = '登録に成功しました'
      redirect_to '/users'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = '削除しました'
      redirect_to '/users'
    else
      flash.now[:alert] = '削除に失敗しました'
      redirect_to '/users'
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '変更に成功しました'
      redirect_to '/users'
    else
      flash.now[:alert] = '変更に失敗しました'
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password)
    # require(:user)はuser内に指定の値が存在するかチェック
    # permit(:email, :password)はemailとpasswordがあるかチェック
    # 結果として、user内にあるemailとpasswordだけを取得
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_logged_in
    redirect_to login_path if current_user.nil?
  end

  def check_edit_authority
    redirect_to users_path unless current_user&.id == params[:id].to_i
  end
end
