# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %I[show edit update destroy followeds followers]

  def edit; end

  def update; end

  def destroy; end

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def followeds
    @followeds = @user.followed_users
  end

  def followers
    @followers = @user.follower_users
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
