FactoryBot.define do
  factory :school do
    sequence(:name) { |n| "Example School #{n}" }
    sequence(:adress) { |n| "City #{n}" }
    phone_number { '123456789' }
    status { 'public' }
    closed { false }
    # association :admin, factory: :user
  end
end
