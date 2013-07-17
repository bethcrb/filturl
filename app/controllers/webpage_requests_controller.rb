class WebpageRequestsController < ApplicationController
  def show
    @webpage_request = WebpageRequest.find(params[:id])
    @webpage_response = @webpage_request.webpage_response
  end

  def create
    request_url = webpage_request_params[:url]

    @webpage_request = WebpageRequest.find_or_initialize_by({ :url => request_url, :user_id => current_user.id })

    respond_to do |format|
      if @webpage_request.save
        format.html { redirect_to @webpage_request }
        format.json { render action: 'show', status: :created, location: @webpage_request }
      else
        format.html { render "home/index", notice: @webpage_request.errors  }
        format.json { render json: @webpage_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def webpage_request_params
      params.require(:webpage_request).permit(:url)
    end
end
