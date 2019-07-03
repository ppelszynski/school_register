FactoryBot.define do
  factory :school_application do
    school_class { create(:school_class) }
    user { create(:user) }
  end
end
