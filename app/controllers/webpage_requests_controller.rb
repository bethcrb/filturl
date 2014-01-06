# The WebpageRequests controller is used to create new webpage requests through
# the submission of a URL in webpage_requests#index. If the submission is
# successful in webpage_requests#create, it redirects to the webpages#show
# path for the URL's effective location after accounting for redirects.
class WebpageRequestsController < ApplicationController
  before_action :current_or_guest_user
  before_action :set_webpage_request, only: :create

  def index
    @webpage_request = WebpageRequest.new
  end

  def create
    respond_to do |format|
      if @webpage_request.save
        format.html { redirect_to @webpage_request.webpage }
      else
        flash.now[:alert] = @webpage_request.errors.full_messages.to_sentence
        format.html { render action: 'index' }
      end
    end
  end

  private

  def set_webpage_request
    @webpage_request = WebpageRequest.find_or_initialize_by(
      url:     PostRank::URI.clean(webpage_request_params[:url]).to_s,
      user_id: current_or_guest_user.id
    )
  end

  def webpage_request_params
    params.require(:webpage_request).permit(:url)
  end
end
