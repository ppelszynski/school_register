class ConfirmationForm < Patterns::Form
  param_key 'user'

  attribute :password, String
  attribute :password_confirmation, String
  attribute :reset_password_token, String

  validates :password, length: { minimum: 6 }

  private

  def persist
    confirm_teacher
  end

  def confirm_teacher
    resource.update_attributes(attributes)
    resource.confirm
  end
end
