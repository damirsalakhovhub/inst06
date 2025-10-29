class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def switch
    organization = current_user.organizations.find(params[:id])
    session[:organization_id] = organization.id
    redirect_to root_path, notice: "Switched to #{organization.name}"
  end
end
