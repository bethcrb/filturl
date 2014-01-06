# The Webpages controller is used to show information about a given URL. Users
# are redirected to webpages#show after a successful URL submission and
# also access it directly through the use of the Webpage friendly ID.
class WebpagesController < ApplicationController
  before_action :current_or_guest_user
  before_action :set_webpage, only: :show
  before_action :set_webpage_request, only: :show
  before_action :set_webpage_response, only: :show
  before_action :set_screenshot, only: :show

  def show
  end

  private

  def set_webpage
    @webpage = Webpage.friendly.find(params[:id])
  end

  def set_webpage_request
    @webpage_request = @webpage.webpage_requests.find_by(
      user_id: current_or_guest_user.id
    )
    redirect_to root_path unless @webpage_request
  end

  def set_webpage_response
    @webpage_response = @webpage.webpage_responses.last
    if @webpage_response.updated_at < 15.minutes.ago
      @webpage_request.send(:perform_http_request)
    end
  end

  def set_screenshot
    @screenshot = @webpage.screenshot
    @screenshot.upload_screenshot if @screenshot.needs_update?
  end
end
