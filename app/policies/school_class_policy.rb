class SchoolClassPolicy < ApplicationPolicy
  def update?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def show?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def index?
    user && (user.is_admin? || user.is_candidate? || user.has_role?(:school_creator))
  end

  def create?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def destroy?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  alias new? create?
  alias edit? update?
end
