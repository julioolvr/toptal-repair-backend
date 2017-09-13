class RepairPolicy < ApplicationPolicy
  def initialize(user, record)
    super
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
  end

  def create?
    user.manager?
  end

  def update?
    user.manager? || show?
  end

  def destroy?
    user.manager?
  end

  class Scope < Scope
    def resolve
      if user.manager?
        scope.all
      else
        scope.where(assignee: user)
      end
    end
  end
end
