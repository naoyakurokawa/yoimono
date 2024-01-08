# frozen_string_literal: true

module Api
  class RelationshipsController < ActionController::API
    include SessionsHelper
    before_action :current_user

    def index
      render json: Relationship.filter_by_followed(params[:followed_id]).select(:id, :follower_id, :followed_id)
    end

    def create
      @user = User.find(params[:followed_id])
      @current_user.follow(@user)
      # @current_user.active_relationships.create!(relationships_params)
      head :created
    end

    def destroy
      user = Relationship.find(params[:id]).followed
      @current_user.unfollow(user)
      head :ok
    end

    private

    def relationships_params
      params.require(:relationship).permit(:followed_id, :format)
    end
  end
end
