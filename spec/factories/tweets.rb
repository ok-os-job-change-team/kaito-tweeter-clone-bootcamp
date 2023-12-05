# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    tweet_content { 'sample_contet' }
    # association :user, factory: :user
    # association :user
  end
end
