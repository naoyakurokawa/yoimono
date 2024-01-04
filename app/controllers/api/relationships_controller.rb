# frozen_string_literal: true

module Api
  class RelationshipsController < ActionController::API
    before_action :logged_in_user

    def index
      render json: Relationship.filter_by_followed(params[:followed_id]).select(:id, :follower_id, :followed_id)
    end

    def create
      @user = User.find(params[:followed_id])
      current_user.active_relationships.create!(relationships_params)
      @user.create_notification_follow!(current_user)
      head :created
    end

    def destroy
      current_user.active_relationships.find(params[:id]).destroy!
      head :ok
    end

    private

    def relationships_params
      params.require(:relationship).permit(:followed_id)
    end
  end
end
