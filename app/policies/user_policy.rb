class UserPolicy < ApplicationPolicy
  def set_password?
    !record.confirmed?
  end

  def confirm?
    !record.confirmed?
  end
end
