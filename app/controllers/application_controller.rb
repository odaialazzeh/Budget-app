class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def after_update_path_for(resource)
    group_path(resource.group)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to authenticated_root_url, alert: exception.message
  end
end
