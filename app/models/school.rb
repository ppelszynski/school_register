class School < ApplicationRecord
  belongs_to :admin, class_name: 'User'

  PUBLIC = 'public'.freeze
  PRIVATE = 'private'.freeze
  STATUSES = [PUBLIC, PRIVATE].freeze

  resourcify
end
