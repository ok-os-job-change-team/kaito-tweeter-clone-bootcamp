# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'User', inverse_of: :active_relationships
  belongs_to :follower, class_name: 'User', inverse_of: :active_relationships
end
