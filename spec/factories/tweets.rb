# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    title { 'sample_title' }
    content { 'sample_contet' }
  end
end
