# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    tweet_title { 'sample_title' }
    tweet_content { 'sample_contet' }
  end
end
