class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # If authorization fails, set error message and redirect to home page
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :login) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :username, :login) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :username, :password, :password_confirmation, :login) }
  end
end
