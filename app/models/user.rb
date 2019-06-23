class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  has_many :schools, foreign_key: 'admin_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def assign_default_role
    self.add_role(:school_admin) if self.roles.blank?
  end
end
