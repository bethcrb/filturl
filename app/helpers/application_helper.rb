# This is the base application helper module. Methods added to this helper will
# be available to all views in the application.
module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  protected

  def chartbeat_enabled?
    ENV['CHARTBEAT_UID'].present? && ENV['CHARTBEAT_DOMAIN'].present?
  end

  def google_analytics_enabled?
    ENV['GOOGLE_ANALYTICS_ID'].present?
  end
end
