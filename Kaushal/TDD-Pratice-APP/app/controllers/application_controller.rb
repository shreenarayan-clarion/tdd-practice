class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:name, :password, :password_confirmation, :invitation_token) }
    devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:name, :password, :password_confirmation, :invitation_token) }
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def pundit_user
    current_admin
  end
end
