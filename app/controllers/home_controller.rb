class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @organizations = policy_scope(Organization)
    @projects = current_organization ? policy_scope(Project).where(organization: current_organization).limit(5) : []
  end
end
