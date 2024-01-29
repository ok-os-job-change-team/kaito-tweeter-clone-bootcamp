class RelationshipsController < ApplicationController
  before_action :check_logged_in, only: %i[create destroy]

  # POST /users/:user_id/relationships
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    if follow.save
      flash[:notice] = 'フォローしました'
      redirect_to users_path
    else
      flash.now[:alert] = 'フォローに失敗しました'
      render users_path
    end
  end

  # DELETE /users/:user_id/relationships
  def destroy
    follow = find_follow(params[:user_id])
    if follow.destroy
      flash[:notice] = 'フォロー解除しました'
      redirect_to users_path
    else
      flash.now[:alert] = 'フォロー解除に失敗しました'
      render users_path
    end
  rescue ActiveRecord::RecordNotFound
    render users_path
  end

  private

  def find_follow(target_user_id)
    current_user.active_relationships.find_by!(follower_id: target_user_id)
  end
end
