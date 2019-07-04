class TeacherForm < Patterns::Form
  param_key 'user'

  attribute :email, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :password, String
  attribute :password_confirmation, String

  validates :email, presence: true

  attr_reader :resource

  private

  def persist
    resource.skip_confirmation_notification!
    resource.update_attributes(attributes)
  end
end
