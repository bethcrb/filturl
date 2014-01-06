# The WebpageRequests controller is used to create new webpage requests through
# the submission of a URL in webpage_requests#index. If the submission is
# successful in webpage_requests#create, it redirects to the webpages#show
# path for the URL's effective location after accounting for redirects.
class WebpageRequestsController < ApplicationController
  before_filter :current_or_guest_user

  def index
    @webpage_request = WebpageRequest.new
  end

  def create
    request_url = PostRank::URI.clean(webpage_request_params[:url]).to_s

    @webpage_request = WebpageRequest.find_or_initialize_by(
      url:     request_url,
      user_id: current_or_guest_user.id
    )

    respond_to do |format|
      if @webpage_request.save
        format.html { redirect_to webpage_path(@webpage_request.webpage) }
      else
        errors_full = @webpage_request.errors.full_messages
        url_error = request_url.present? ? "#{request_url}:" : "Error:"
        flash.now[:alert] = "#{url_error} #{errors_full.to_sentence}"
        format.html { render 'index' }
      end
    end
  end

  private

  def webpage_request_params
    params.require(:webpage_request).permit(:url)
  end
end
