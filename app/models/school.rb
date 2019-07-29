class School < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  has_many :school_classes

  def students
    SchoolStudentsQuery.call(User.all, school: self)
  end

  PUBLIC = 'public'.freeze
  PRIVATE = 'private'.freeze
  STATUSES = [PUBLIC, PRIVATE].freeze

  resourcify
end
