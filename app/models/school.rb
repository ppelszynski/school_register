class School < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  has_many :school_classes
 

  PUBLIC = 'public'.freeze
  PRIVATE = 'private'.freeze
  STATUSES = [PUBLIC, PRIVATE].freeze

  resourcify
end
