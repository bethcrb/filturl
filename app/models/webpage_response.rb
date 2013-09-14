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

  has_one :screenshot, through: :webpage

  validates :webpage_request, presence: true

  after_create :get_url

  def get_url
    response = Typhoeus.get(webpage_request.url, followlocation: true,
      ssl_verifypeer: false)
    webpage_url = response.effective_url || webpage_request.url
    webpage = Webpage.find_or_initialize_by(url: webpage_url)
    webpage.update_attributes!(
      primary_ip: response.primary_ip,
      body: response.response_body.force_encoding('ISO-8859-1')
        .encode('utf-8', replace: nil))

    response_data = {
      code:           response.response_code,
      headers:        response.response_headers,
      redirect_count: response.redirections.size,
      webpage_id:     webpage.id,
    }
    self.update_attributes!(response_data)
  end
end
