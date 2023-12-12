class ApplicationController < ActionController::Base
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_logged_in
    if current_user.nil?
      flash[:alert] = 'ログインしてください'
      redirect_to login_path
    end
  end

  def check_edit_authority
    flash[:alert] = '自分以外のユーザーは編集・削除できません'
    redirect_to users_path unless current_user&.id == params[:id].to_i
  end
end
