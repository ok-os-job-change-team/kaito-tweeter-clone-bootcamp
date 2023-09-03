# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "john@example.com" }
    password { "secret_password" }
  end
end
