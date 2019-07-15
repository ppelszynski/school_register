class StudentForm < Patterns::Form
  param_key 'user'

  attribute :email, String
  attribute :phone_number, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :password, String
  attribute :city, String
  attribute :password_confirmation, String

  validates :email, :city, length: { minimum: 2 }

  private

  attr_reader :resource

  def persist
    resource.update_attributes(attributes)
    resource.add_role(:candidate)
  end
end
