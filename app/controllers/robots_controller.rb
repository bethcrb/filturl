# This controller is used to render environment-specific robots.txt
# files.
class RobotsController < ApplicationController
  def show
    robots_path = Rails.root.join('config/robots').to_s
    robots_txt = "#{robots_path}/#{Rails.env}.txt"

    # Default to the robots.txt for the development environment if a
    # robots.txt file does not exist for the current environment.
    robots_txt = "#{robots_path}/development.txt" unless File.exist? robots_txt
    if File.exist? robots_txt
      render text: File.read(robots_txt), content_type: 'text/plain'
    end
  end
end
