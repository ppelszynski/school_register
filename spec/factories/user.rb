FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { password }

    after(:create, &:confirm)

    transient do
      school { nil }
      school_class { nil }
    end

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    trait :school_creator do
      after(:create) { |user| user.add_role(:school_creator) }
    end

    trait :school_admin do
      after(:create) do |user, evaluator|
        user.add_role(:school_admin)
        user.add_role(:school_admin, evaluator.school) if evaluator.school
      end
    end

    trait :teacher do
      after(:create) do |user, evaluator|
        user.add_role(:teacher, evaluator.school) if evaluator.school
      end
    end

    trait :candidate do
      after(:create) { |user| user.add_role(:candidate) }
    end
  end

  trait :student do
    after(:create) do |user, evaluator|
      user.add_role(:student, evaluator.school_class) if evaluator.school_class
    end
  end
end
