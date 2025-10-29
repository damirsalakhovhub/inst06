class OrganizationPolicy < ApplicationPolicy
  def show?
    membership.present?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.none unless user

      scope.joins(:memberships).where(memberships: { user_id: user.id }).distinct
    end
  end
end
