# frozen_string_literal: true

class Tweet < ApplicationRecord
  validates :user, presence: true
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :favorites

  def favorited_by?(target_user_id)
    favorites.where(user_id: target_user_id).exists?
  end
end
