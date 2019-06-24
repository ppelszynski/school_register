class AssignDefaultRole < Patterns::Service
  def initialize(user)
    @user = user
  end

  def call
    @user.add_role(:school_admin)
    @user
  end

  private

  attr_reader :user
end
