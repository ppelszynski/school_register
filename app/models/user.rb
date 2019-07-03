class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify
  has_many :schools, foreign_key: 'admin_id'
  has_many :school_applications

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
end
