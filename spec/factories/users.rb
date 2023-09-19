# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'sample@example.com' }
    password { 'sample_password' }
  end
end
