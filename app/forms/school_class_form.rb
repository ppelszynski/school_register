class SchoolClassForm < Patterns::Form
  param_key 'school_class'

  attribute :name, String
  attribute :symbol, String
  attribute :slots, Integer

  validates :name, length: { minimum: 2 }

  attr_reader :resource

  private

  def persist
    resource.update_attributes(attributes)
  end
end
