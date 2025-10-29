class MembershipPolicy < ApplicationPolicy
  def show?
    membership.present?
  end

  def create?
    owner_or_admin?
  end

  def update?
    return false unless owner_or_admin?
    return false if record.role == 'owner' && !owner?
    true
  end

  def destroy?
    return false unless owner_or_admin?
    return false if record.role == 'owner'
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user && organization

      scope.where(organization: organization)
    end
  end
end
