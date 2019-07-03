class SchoolApplication < ApplicationRecord
  validates_uniqueness_of :user_id, scope: [:school_class_id]

  belongs_to :school_class
  belongs_to :user
end
