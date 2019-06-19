FactoryBot.define do
  factory :school do
    name { 'Example School' }
    sequence(:adress) { |n| "City #{n}" }
    phone_number { '123456789' }
    status { 'public' }
    closed { false }
    association :admin, factory: :user
  end
end
