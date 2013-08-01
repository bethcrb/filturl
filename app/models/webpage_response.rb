# == Schema Information
#
# Table name: webpage_responses
#
#  id                 :integer          not null, primary key
#  redirect_count     :integer
#  code               :integer
#  headers            :text
#  webpage_request_id :integer
#  webpage_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class WebpageResponse < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :webpage_request

  has_one :webpage_screenshot, through: :webpage

  validates :webpage_request, presence: true

  after_create :get_url

  def get_url
    response = Typhoeus.get(self.webpage_request.url, followlocation: true,
      ssl_verifypeer: false)
    effective_url = response.effective_url || self.webpage_request.url
    self.webpage = Webpage.find_or_initialize_by(effective_url: effective_url)
    self.webpage.update_attributes!(
      primary_ip: response.primary_ip,
      body: response.response_body.force_encoding("ISO-8859-1")
        .encode("utf-8", replace: nil) )

    response_data = {
      :code           => response.response_code,
      :headers        => response.response_headers,
      :redirect_count => response.redirect_count,
      :webpage_id     => webpage.id,
    }
    self.update_attributes!(response_data)

    self.webpage.create_webpage_screenshot!
  end
end
