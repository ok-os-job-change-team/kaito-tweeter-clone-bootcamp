# frozen_string_literal: true

class Tweet < ApplicationRecord
  validates :user_id, presence: true
  validates :body, presence: true

  belongs_to :user # アソシエーション
end
