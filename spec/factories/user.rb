# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    trait :school_admin do
      after(:create) { |user| user.add_role(:school_admin) }
    end
  end
end
