# This controller is used to both create new webpage requests and show
# existing ones. It involves the submission of a URL (create) and the
# ability to view the resulting webpage data (show).
class WebpageRequestsController < ApplicationController
  before_filter :current_or_guest_user

  def index
    @webpage_request = WebpageRequest.new
  end

  def show
    @webpage_request = WebpageRequest.friendly.find(params[:id])
    if @webpage_request
      if current_or_guest_user.id ==  @webpage_request.user_id
        @webpage_response = @webpage_request.webpage_response
        @webpage = @webpage_response.webpage
        @screenshot = @webpage.screenshot
        if user_signed_in?
          @screenshot.upload_screenshot if @screenshot.needs_update?
        end
      else
        raise CanCan::AccessDenied
      end
    end
  end

  def create
    request_url = PostRank::URI.clean(webpage_request_params[:url]).to_s

    @webpage_request = WebpageRequest.find_or_initialize_by(
      url:     request_url,
      user_id: current_or_guest_user.id
    )

    unless (current_user || session[:verified_captcha])
      if verify_recaptcha(timeout: 15)
        session[:verified_captcha] = true
      end
    end

    respond_to do |format|
      if (current_user || session[:verified_captcha]) && @webpage_request.save
        format.html { redirect_to @webpage_request }
      else
        if (current_user || session[:verified_captcha])
          errors_full = @webpage_request.errors.full_messages
          flash.now[:alert] = "#{request_url}: #{errors_full.to_sentence}"
        end
        format.html { render 'index' }
      end
    end
  end

  private

  def webpage_request_params
    params.require(:webpage_request).permit(:url)
  end
end
