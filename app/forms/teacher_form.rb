class TeacherForm < Patterns::Form
  param_key 'user'

  attribute :email, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :password, String
  attribute :password_confirmation, String

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  attr_reader :resource

  private

  def persist
    attributes[:password] = password
    attributes[:password_confirmation] = password

    resource.skip_confirmation_notification!
    resource.update_attributes(attributes)
  end

  def password
    password = Devise.friendly_token.first 8
  end
end
