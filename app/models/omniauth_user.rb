# The OmniauthUser class handles the creation of new users from Omniauth.
class OmniauthUser
  attr_reader :user

  def initialize(auth, signed_in_resource = nil)
    @auth = auth
    @signed_in_resource = nil
    @user = nil
  end

  # Finds or creates a new user based on whether or not a user already exists
  # for their e-mail address and saves Omniauth details.
  def find_or_create_user
    @user = User.find_by(email: auth_email)
    @user ||= create_new_user
    save_omniauth_details

    @user
  end

  private

  # Convenience methods for accessing @auth.info
  def auth_info
    @auth.info
  end

  def auth_nickname
    auth_info.nickname
  end

  def auth_email
    auth_info.email
  end

  # Creates a new user with the e-mail address provided by Omniauth and the
  # the username returned by find_username(). Sets a random password.
  def create_new_user
    username = find_username
    @user = User.new(
      email:    auth_email,
      username: username,
      password: Devise.friendly_token[0, 20],
    )
    @user.skip_confirmation!
    @user.save!

    @user
  end

  # Finds a username based on Omniauth details and existing users.
  def find_username
    # Default to the nickname provided in the Omniauth details. If a nickname
    # was not provided or a user with the same username already exists, use the
    # e-mail address as the username.
    username = auth_nickname
    username = auth_email if username.blank? ||
      User.exists?(username: username)

    username
  end

  # Saves Omniauth details to Authentication model.
  def save_omniauth_details
    authentication = @user.authentications.find_or_create_by(
      provider: auth_info.provider,
      uid:      auth_info.uid,
    )

    authentication.update_attributes!(
      email:    auth_email,
      nickname: auth_nickname,
      image:    auth_info.image,
      raw_info: @auth.to_json,
    )
  end
end
