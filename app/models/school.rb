class School < ApplicationRecord
  PUBLIC = 'public'.freeze
  PRIVATE = 'private'.freeze

  resourcify
  belongs_to :user, foreign_key: 'user_id', optional: true
end
