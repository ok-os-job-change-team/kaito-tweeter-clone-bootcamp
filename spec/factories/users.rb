# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'test_user' }
    email { 'sample@example.com' }
    password { 'sample_password' }
  end
end
