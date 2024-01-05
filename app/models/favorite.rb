# frozen_string_literal: true

class Favorite < ApplicationRecord
  validates :user, presence: true
  validates :tweet, presence: true

  belongs_to :user
  belongs_to :tweet
end
