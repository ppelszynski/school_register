class TeacherCreateForm < Patterns::Form
  param_key 'user'

  attribute :email, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :password, String
  attribute :password_confirmation, String

  validates :email, presence: true

  def teacher # to jebnie
    resource
  end

  private

  def persist
    create_teacher
  end

  def create_teacher
    resource.skip_confirmation!
    resource.update_attributes(attributes)
  end
end
