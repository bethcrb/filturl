# This controller is the base controller for the entire application.
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # If authorization fails, set error message and redirect to home page
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  helper_method :current_or_guest_user

  # If the user is currently logged in, move existing guest user data if
  # necessary and return the current user; otherwise, return the guest user.
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        move_guest_user_data
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # If the user is currently not logged in, find the guest_user object
  # associated with the current session or create one if it does not already
  # exist.
  def guest_user
    # Cache the value the first time it's gotten.
    guest_user_id = session[:guest_user_id] ||= create_guest_user.id
    @cached_guest_user ||= User.find(guest_user_id)

  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user
  end

  private

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
    guest_username = "guest_#{Time.now.to_i}#{rand(99)}"
    guest_user = User.create(
      name:     'Guest',
      email:    "#{guest_username}@#{request.remote_ip}",
      username: guest_username,
    )
    guest_user.save!(validate: false)
    session[:guest_user_id] = guest_user.id
    guest_user
  end
end
