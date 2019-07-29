class SchoolClass < ApplicationRecord
  resourcify

  belongs_to :school
  has_many :school_class_requests
end
