# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true
  validates :password, presence: true

  has_many :tweets
  has_many :favorites
  # <Userモデルのインスタンス>.favorite_tweetsでいいねしたツイートを取得する
  has_many :favorite_tweets, through: :favorites, source: :tweet
end
