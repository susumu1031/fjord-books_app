# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :followers,
           class_name: 'FollowRelationship',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower
  has_many :followeds,
           class_name: 'FollowRelationship',
           foreign_key: 'followed_id',
           dependent: :destroy,
           inverse_of: :followed

  has_many :followed_users, through: :followers, source: :followed # followersを通じてfollowedにたどり着く
  has_many :follower_users, through: :followeds, source: :follower # followedsを通じてfollowerにたどり着く

  # フォローする
  def follow(other_user_id)
    followers.create(followed_id: other_user_id)
  end

  # フォローしているか確認
  def followed?(other_user)
    followed_users.include?(other_user)
  end
end
