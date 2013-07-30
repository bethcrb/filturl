# == Schema Information
#
# Table name: webpage_responses
#
#  id                 :integer          not null, primary key
#  effective_url      :string(255)
#  primary_ip         :string(255)
#  redirect_count     :integer
#  body               :text(2147483647)
#  code               :integer
#  headers            :text
#  webpage_request_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class WebpageResponse < ActiveRecord::Base
  belongs_to :webpage_request

  has_one :webpage_screenshot, dependent: :destroy

  validates :webpage_request, presence: true

  after_create :get_url
  after_create :create_webpage_screenshot!

  def get_url
    response = Typhoeus.get(self.webpage_request.url, followlocation: true,
      ssl_verifypeer: false)
    response_data = {
      :body                => response.response_body.force_encoding("ISO-8859-1").encode("utf-8", replace: nil),
      :code                => response.response_code,
      :effective_url       => response.effective_url,
      :headers             => response.response_headers,
      :primary_ip          => response.primary_ip,
      :redirect_count      => response.redirect_count,
    }

    self.update_attributes!(response_data)
  end

  def screenshot_url
    webpage_screenshot.url
  end
end
