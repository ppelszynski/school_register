class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super

    AssignDefaultRole.call(resource)
  end
end
