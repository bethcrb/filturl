# This is the user sessions controller inherited from Devise.
# It currently serves the purpose of overriding the default permitted
# parameters for signing in.
class Users::Devise::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :username)
    end
  end
end
