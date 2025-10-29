class ProjectPolicy < ApplicationPolicy
  def show?
    membership.present?
  end

  def create?
    !guest?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user && organization

      scope.where(organization: organization)
    end
  end
end
