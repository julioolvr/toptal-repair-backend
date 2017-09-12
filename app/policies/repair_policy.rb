class RepairPolicy < ApplicationPolicy
  def initialize(user, record)
    super
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
  end

  def create?
    user.manager?
  end

  def update?
    true
  end

  def destroy?
    user.manager?
  end
end
