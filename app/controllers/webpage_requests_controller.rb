# The WebpageRequests controller is used to create new webpage requests through
# the submission of a URL in webpage_requests#new and show the results in
# webpage_requests#show.
class WebpageRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_webpage_request, only: :show
  before_action :build_webpage_request, only: :create
  after_action :verify_authorized

  def show
    authorize @webpage_request
  end

  def new
    @webpage_request = WebpageRequest.new
    authorize @webpage_request
  end

  def create
    authorize @webpage_request

    if @webpage_request.save &&
      WebpageService.perform_http_request(@webpage_request)
      redirect_to @webpage_request
    else
      flash.now[:alert] = @webpage_request.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def set_webpage_request
    @webpage_request ||= WebpageRequest.friendly.find(params[:id])
  end

  def build_webpage_request
    @webpage_request = WebpageRequest.find_or_initialize_by(
      url:     PostRank::URI.clean(webpage_request_params[:url]).to_s,
      user_id: current_user.id
    )
  end

  def webpage_request_params
    params.require(:webpage_request).permit(:url)
  end
end
