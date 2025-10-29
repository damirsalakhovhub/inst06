# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :organization

  def initialize(user, record)
    @user = user
    @record = record
    @organization = record.is_a?(Organization) ? record : record.organization rescue nil
  end

  def membership
    return nil unless user && organization
    @membership ||= user.memberships.find_by(organization: organization)
  end

  def role
    membership&.role
  end

  def owner?
    role == 'owner'
  end

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end

  def guest?
    role == 'guest'
  end

  def owner_or_admin?
    owner? || admin?
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(context, scope)
      @user, @organization = context.is_a?(Array) ? context : [context, nil]
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :organization, :scope
  end
end
