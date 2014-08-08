# This controller implements Omniauth callbacks and is used by Omniauth
# providers as the URL to redirect users to after they have authorized the
# application.
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable

  Devise.omniauth_providers.each do |provider|
    define_method provider.to_s do
      authenticate_omniauth
    end
  end

  def authenticate_omniauth
    omniauth_data = request.env['omniauth.auth']
    provider = omniauth_data['provider']
    provider_name = provider == 'google_oauth2' ? 'google' : provider

    @user = OmniauthUser.new(omniauth_data, current_user).find_or_create_user

    if @user.persisted?
      remember_me(@user)

      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(':notice', :success, kind: provider_name.capitalize)
      end
    else
      session["devise.#{provider_name}_data"] = omniauth_data
      redirect_to new_user_registration_url
    end
  end
end
