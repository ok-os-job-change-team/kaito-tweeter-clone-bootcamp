# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'john@example.com' }
    password { 'secret_password' }
  end

  factory :takashi, class: User do
    email { 'takashi@example.com' }
    password { 'hoge_takashi' }
  end

  factory :satoshi, class: User do
    email { 'satoshi@example.com' }
    password { 'hoge_satoshi' }
  end
end
