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
# Indexes
#
#  index_webpage_responses_on_webpage_id          (webpage_id)
#  index_webpage_responses_on_webpage_request_id  (webpage_request_id)
#

class WebpageResponse < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :webpage_request

  has_one :screenshot, through: :webpage
  has_many :webpage_redirects, dependent: :destroy

  validates :webpage_request, presence: true

  after_create :get_url

  def get_url
    response = Typhoeus.get(webpage_request.url, followlocation: true,
      ssl_verifypeer: false)

    webpage_url = response.effective_url || webpage_request.url
    content_type = response.headers['Content-Type']
    mime_type = MIME::Types[content_type]

    webpage = Webpage.find_or_initialize_by(url: webpage_url)
    webpage.primary_ip = response.primary_ip
    if mime_type.present? && mime_type.first.ascii?
      content = response.response_body
      unless content.is_utf8?
        content.force_encoding('ISO-8859-1').encode!('UTF-8')
      end
      webpage.body = content
    end
    webpage.save!

    response_data = {
      code:           response.response_code,
      headers:        response.response_headers,
      redirect_count: response.redirections.size,
      webpage_id:     webpage.id,
    }
    self.update_attributes!(response_data)

    response.redirections.each do |redirection|
      webpage_redirects.find_or_create_by!(url: redirection.headers[:location])
    end
  end
end
