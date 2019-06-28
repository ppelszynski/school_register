class SchoolPolicy < ApplicationPolicy
  def show?
    user.confirmed?
  end

  def create?
    user.confirmed?
  end
end
