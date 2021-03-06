class SchoolPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_admin? || user.is_candidate?
        scope.all
      else
        scope.where(admin_id: user.id)
      end
    end
  end

  def update?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def show?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def index?
    user && (user.is_admin? || user.is_candidate? || user.is_school_creator?)
  end

  def create?
    user.is_admin? || user.is_school_creator?
  end

  def destroy?
    user.is_admin? || user.has_role?(:school_admin, record)
  end

  def create_teacher?
    user&.is_admin? || user&.has_role(:school_teacher, record)
  end

  alias new? create?
  alias edit? update?
end
