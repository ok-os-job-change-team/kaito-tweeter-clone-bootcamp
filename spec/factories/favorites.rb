# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    # associationは使い方が分からないので一旦コメントアウト
    association :user
    association :tweet
  end
end
