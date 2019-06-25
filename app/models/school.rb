class School < ApplicationRecord
  belongs_to :admin, class_name: 'User'

  PUBLIC = 'public'.freeze
  PRIVATE = 'private'.freeze
  STATUSES = [PUBLIC, PRIVATE].freeze

  validates :status, inclusion: { in: STATUSES }

  resourcify
end
