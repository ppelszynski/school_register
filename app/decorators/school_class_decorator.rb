class SchoolClassDecorator < Draper::Decorator
  delegate_all

  def free_slots
    slots - User.with_role(:student, object).count
  end
end
