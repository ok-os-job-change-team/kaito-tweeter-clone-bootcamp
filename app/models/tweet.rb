# frozen_string_literal: true

class Tweet < ApplicationRecord
  validates :user, presence: true
  validates :tweet_content, presence: true

  belongs_to :user # アソシエーション
end
