class HomeController < ApplicationController
  def index
    @webpage_request = WebpageRequest.new
  end
end
