# This controller is the base controller for the entire application.
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  before_action :save_previous_url

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_path
  end

  private

  # Save previous URL in order to redirect back to it after the user signs in.
  def save_previous_url
    # Do not save AJAX calls or URLs for the Users controllers
    return if request.fullpath =~ %r{^/users/} || request.xhr?
    session[:previous_url] = request.fullpath
  end

  # Redirect to either the previous URL or the home page after signing in.
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
end
