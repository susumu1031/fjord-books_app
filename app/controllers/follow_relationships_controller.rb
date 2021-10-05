# frozen_string_literal: true

class FollowRelationshipsController < ApplicationController
  def create
    user = User.find(params[:follow_id])
    current_user.follow(params[:follow_id])
    redirect_to user_path(user)
  end

  def destroy
    FollowRelationship.find_by(follower_id: current_user.id, followed_id: params[:id]).destroy
    redirect_to user_path
  end
end
