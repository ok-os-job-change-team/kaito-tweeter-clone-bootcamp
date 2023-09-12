# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true
  validates :password, presence: true
end
