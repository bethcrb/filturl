class WebpageRequest < ActiveRecord::Base
  belongs_to :requestor, class_name: "User"

  has_one :webpage_response, dependent: :destroy

  validates :url, presence: true, uniqueness: true, format: URI::regexp(%w(http https))

  def get_response
    request = Typhoeus.get(self.url, followlocation: true)
    response_body = request.response_body.force_encoding(Encoding::UTF_8)
    
    self.webpage_response = WebpageResponse.new({
      :app_connect_time    => request.app_connect_time,
      :connect_time        => request.connect_time,
      :effective_url       => request.effective_url,
      :httpauth_avail      => request.httpauth_avail,
      :name_lookup_time    => request.name_lookup_time,
      :pretransfer_time    => request.pretransfer_time,
      :primary_ip          => request.primary_ip,
      :redirect_count      => request.redirect_count,
      :body                => request.response_body.force_encoding("ISO-8859-1").encode("utf-8", replace: nil),
      :code                => request.response_code,
      :headers             => request.response_headers,
      :return_message      => request.return_message,
      :start_transfer_time => request.start_transfer_time,
      :total_time          => request.total_time,
    })
  end
end
