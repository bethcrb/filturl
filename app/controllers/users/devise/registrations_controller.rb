# This is the user registrations controller inherited from Devise.
# It currently serves the purpose of overriding Devise to allow users to edit
# their account without providing their current password. It also configures
# the permitted parameters for :account_update and :sign_up.
class Users::Devise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in'
  end

  # Override Devise's update method so that users can edit their account
  # without providing their current password.
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # This is required for the form to submit when the password is left blank.
    if account_update_params[:password].blank?
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message ':notice', :updated

      # Sign in the user and bypass validation in case the password changed.
      sign_in @user, bypass: true
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :username, :password, :password_confirmation,
               :current_password
      )
    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :username, :password, :password_confirmation)
    end
  end
end
