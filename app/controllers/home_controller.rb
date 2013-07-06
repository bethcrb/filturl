class HomeController < ApplicationController
  def index
    @webpage = Webpage.new
  end
end
