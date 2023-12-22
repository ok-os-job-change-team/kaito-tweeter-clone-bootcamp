# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    user { association(:user) }
    tweet { association(:tweet, user: user) }
  end
end
