# This is the user registrations controller inherited from Devise.
# It currently serves the purpose of overriding Devise to allow users to edit
# their account without providing their current password.
class RegistrationsController < Devise::RegistrationsController
  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in'
  end

  # Override Devise's update method so that users can edit their account
  # without providing their current password.
  def update
    # This is required for the form to submit when the password is left blank.
    if params[:user][:password].blank?
      params[:user].delete('password')
      params[:user].delete('password_confirmation')
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(devise_parameter_sanitizer.for(:account_update))
      set_flash_message :notice, :updated

      # Sign in the user and bypass validation in case the password changed.
      sign_in @user, bypass: true
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end
end
