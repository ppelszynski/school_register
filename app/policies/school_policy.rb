class SchoolPolicy < ApplicationPolicy
  def update?
    admin_required || owner_required
  end

  def show?
    admin_required || owner_required
  end

  def index?
    admin_required || school_admin_required
  end

  def create?
    admin_required || school_admin_required
  end

  def destroy?
    admin_required || owner_required
  end

  private

  def admin_required
    @user.is_admin?
  end

  def school_admin_required
    @user.has_role?(:school_admin)
  end

  def owner_required
    @user.has_role?(:school_admin, @record)
  end
end
