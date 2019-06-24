class SchoolPolicy < ApplicationPolicy
  def update?
    admin_required || owner_required
  end

  def create?
    admin_required
  end

  def destroy?
    admin_required || owner_required
  end

  private

  def admin_required # wiem ze is_ itp ale to zle wyglada i jest private
    user.is_admin?
  end

  def owner_required
    user.has_role?(:school_admin, @school)
  end
end
