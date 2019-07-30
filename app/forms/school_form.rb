class SchoolForm < Patterns::Form
  param_key 'school'

  attribute :name, String
  attribute :adress, String
  attribute :phone_number, String
  attribute :status, String

  validates :name, length: { minimum: 2 }
  validates :status, inclusion: { in: School::STATUSES }

  attr_reader :resource

  private

  def persist
    create_school
  end

  def create_school
    resource.update_attributes(attributes)
  end
end
