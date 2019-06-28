FactoryBot.define do
  factory :school do
    sequence(:name) { |n| "Example School #{n}" }
    sequence(:adress) { |n| "City #{n}" }
    phone_number { '123456789' }
    status { 'public' }
    is_closed { false }
    admin { create(:user) }

    after(:create) do |school|
      school.admin.add_role(:school_admin, school)
    end
  end
end
