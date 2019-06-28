class TeacherCreateForm < Patterns::Form
  param_key 'user'

  attribute :password, String
  attribute :password_confirmation, String

  private

  def persist
    create_teacher
  end

  def create_teacher
    resource.update_attributes(attributes)
  end
end
