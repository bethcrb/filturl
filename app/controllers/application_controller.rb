# This controller is the base controller for the entire application.
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  before_action :save_previous_url

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # If authorization fails, set error message and redirect to home page
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path
  end

  helper_method :current_or_guest_user

  private

  # If the user is currently logged in, move existing guest user data if
  # necessary and return the current user; otherwise, return the guest user.
  def current_or_guest_user
    if current_user
      if cookies[:guest]
        move_guest_user_data
        cookies.delete(:guest)
      end
      current_user
    else
      guest_user
    end
  end

  # Save previous URL in order to redirect back to it after the user signs in.
  def save_previous_url
    # Do not save AJAX calls or URLs for the Users controllers
    unless request.fullpath =~ %r{^/users/} || request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  # Redirect to either the previous URL or the home page after signing in.
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  # If the user is currently not logged in, find the guest_user object
  # associated with the current session or create one if it does not already
  # exist.
  def guest_user
    # Cache the value the first time it's gotten.
    if cookies[:guest]
      if cookies[:guest].is_a? Integer
        guest_user_id = cookies[:guest]
      else
        guest_user_id = Base64.urlsafe_decode64(cookies[:guest])
      end
    end
    guest_user_id ||= create_guest_user.id

    @cached_guest_user ||= User.find(guest_user_id)

  rescue ActiveRecord::RecordNotFound
    cookies.delete(:guest)
    guest_user
  end

  # When the user logs in, move any webpage requests they made during their
  # guest user session.
  def move_guest_user_data
    webpage_requests = guest_user.webpage_requests
    webpage_requests.each do |webpage_request|
      # Replace existing webpage request this user made during their
      # guest user session for the same URL.
      existing_webpage_request = WebpageRequest.find_by(
        url:     webpage_request.url,
        user_id: current_user.id
      )
      if existing_webpage_request.present?
        existing_webpage_request.destroy!
      end

      webpage_request.user_id = current_user.id
      webpage_request.save!
    end
  end

  # Create a guest user account with a random username and the client IP
  # address.
  def create_guest_user
    guest_username = "guest_#{SecureRandom.uuid}"
    guest_user = User.new(
      email:    "#{guest_username}@#{request.remote_ip}",
      username: guest_username,
    )
    guest_user.skip_confirmation!
    guest_user.save!(validate: false)
    cookies[:guest] = Base64.urlsafe_encode64(guest_user.id.to_s)
    guest_user
  end
end
