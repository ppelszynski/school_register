require 'rails_helper'

module FeatureHelper
  def create_school(owner:, name:)
    school = create(:school, admin_id: owner.id)
    owner.add_role(:school_admin, school)
    school
  end
end
