# Extends the ApplicationController to add Pundit for authorization.
# Be sure to restart your server when you modify this file.
module PunditHelper
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    redirect_to root_path, alert: 'Access denied.'
  end
end

ApplicationController.send :include, PunditHelper
