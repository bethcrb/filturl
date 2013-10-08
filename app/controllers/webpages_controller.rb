class WebpagesController < ApplicationController
  before_filter :verify_user

  def show
    @webpage = Webpage.friendly.find(params[:id])
    if @webpage.present?
      @webpage_request = @webpage.webpage_requests.find_by(user_id: current_or_guest_user.id)
      if @webpage_request.present?
        @webpage_response = @webpage.webpage_responses.last
        if (@webpage_response.updated_at < 15.minutes.ago)
          @webpage_response.get_url
        end
        @screenshot = @webpage.screenshot
        if user_signed_in?
          @screenshot.upload_screenshot if @screenshot.needs_update?
        end
      end
    end
  end

  protected
  
  def verify_user
    redirect_to root_path unless current_user || session[:verified_captcha]
  end
end
