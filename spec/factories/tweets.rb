# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    title { 'sample_title' }
    text_area { 'sample_contet' }
  end
end
