class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify
  has_many :schools, foreign_key: 'admin_id'

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
end
