class SchoolPolicy < ApplicationPolicy
  def update?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def show?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def index?
    user.is_admin? || user.has_role?(:school_admin)
  end

  def create?
    user.is_admin? || user.has_role?(:school_admin)
  end

  def destroy?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def create_teacher?
    user&.is_admin? || user&.has_role(:school_teacher, record)
  end
end
