FactoryBot.define do
  factory :school_class do
    sequence(:name) { |n| "Example Class #{n}" }
    sequence(:symbol) { |n| "#{n}ABC" }
    slots { 30 }
    school { create(:school) }
  end
end
