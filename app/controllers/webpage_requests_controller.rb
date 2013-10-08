# This controller is used to both create new webpage requests and show
# existing ones. It involves the submission of a URL (create) and the
# ability to view the resulting webpage data (show).
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

    unless (current_user || session[:verified_captcha])
      if verify_recaptcha(timeout: 15)
        session[:verified_captcha] = true
      end
    end

    respond_to do |format|
      if (current_user || session[:verified_captcha]) && @webpage_request.save
        format.html { redirect_to @webpage_request.webpage }
      else
        if (current_user || session[:verified_captcha])
          errors_full = @webpage_request.errors.full_messages
          url_error = request_url.present? ? "#{request_url}:" : "Error:"
          flash.now[:alert] = "#{url_error} #{errors_full.to_sentence}"
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
