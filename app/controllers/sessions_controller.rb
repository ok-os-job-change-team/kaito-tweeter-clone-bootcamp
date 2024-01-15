class SessionsController < ApplicationController
  layout 'header'

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:alert] = 'メールアドレスかパスワードが間違っています'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
