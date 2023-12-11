class ApplicationController < ActionController::Base
  private
  
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
