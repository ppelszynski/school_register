class SchoolPolicy < ApplicationPolicy
  def show?
    !user.confirmed?
  end

  def update?
    !user.confirmed?
  end
end
