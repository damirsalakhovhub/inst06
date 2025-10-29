class TaskPolicy < ApplicationPolicy
  def show?
    membership.present?
  end

  def create?
    !guest?
  end

  def update?
    return false if guest?
    return true if owner_or_admin?
    record.assigned_user_id == user.id
  end

  def destroy?
    owner_or_admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user && organization

      scope.joins(:project).where(projects: { organization: organization })
    end
  end
end
