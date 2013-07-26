class WebpageRequestsController < ApplicationController
  def index
    @webpage_request = WebpageRequest.new
  end

  def show
    @webpage_request = WebpageRequest.friendly.find(params[:id])
    @webpage_response = @webpage_request.webpage_response
  end

  def create
    request_url = PostRank::URI.clean(webpage_request_params[:url]).to_s

    @webpage_request = WebpageRequest.find_or_initialize_by(
      url:     request_url,
      user_id: current_user.id
    )

    respond_to do |format|
      if @webpage_request.save
        format.html { redirect_to @webpage_request }
        format.json { render action: 'show', status: :created, location: @webpage_request }
      else
        flash.now[:alert] = "#{request_url}: #{@webpage_request.errors.full_messages.to_sentence.gsub(/Url/, 'url')}"
        format.html { render "index" }
        format.json { render json: @webpage_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def webpage_request_params
      params.require(:webpage_request).permit(:url)
    end
end
