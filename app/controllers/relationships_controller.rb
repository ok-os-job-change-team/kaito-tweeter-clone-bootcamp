class RelationshipsController < ApplicationController
  before_action :check_logged_in, only: %i[create destroy]

  # POST /users/:user_id/relationships
  def create
    # createアクションの処理を書く
  end

  # DELETE /users/:user_id/relationships
  def destroy
    # destroyアクションの処理を書く
  end
end
