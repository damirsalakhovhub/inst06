class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def pundit_user
    [ current_user, current_organization ]
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def record_not_found
    flash[:alert] = "Record not found."
    redirect_to(root_path)
  end

  def current_organization
    @current_organization ||= current_user&.organizations&.find_by(id: session[:organization_id]) ||
                              current_user&.organizations&.first
  end
  helper_method :current_organization
end
