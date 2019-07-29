FactoryBot.define do
  factory :school_class_request do
    school_class { create(:school_class) }
    user { create(:user) }
  end
end
