class UserPolicy < ApplicationPolicy
  def initialize(user, record)
    super
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
  end

  def index?
    user.manager?
  end

  def show?
    user.manager?
  end

  def create?
    user.manager?
  end

  def update?
    user.manager?
  end

  def destroy?
    user.manager?
  end
end
