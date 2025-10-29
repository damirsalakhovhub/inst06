class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_membership, only: [ :update, :destroy ]

  def index
    @memberships = policy_scope(Membership).where(organization: current_organization)
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.organization = current_organization
    # rubocop:disable Rails/StrongParameters
    @membership.user_id = params[:membership][:user_id] if params[:membership][:user_id].present?
    # rubocop:enable Rails/StrongParameters
    authorize @membership

    if @membership.save
      redirect_to memberships_path, notice: "Member was successfully added."
    else
      @memberships = policy_scope(Membership).where(organization: current_organization)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    authorize @membership
    if @membership.update(membership_params)
      redirect_to memberships_path, notice: "Member role was successfully updated."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @membership
    @membership.destroy
    redirect_to memberships_path, notice: "Member was successfully removed."
  end

  private

  def set_membership
    @membership = current_organization.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:role)
  end
end
