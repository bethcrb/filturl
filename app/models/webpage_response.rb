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

  validates :webpage_request, presence: true

  after_create :get_url

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

    generate_screenshot

    self.update_attributes!(response_data)
  end

  def screenshot_filename
    "#{self.webpage_request.slug}.png"
  end

  def temp_screenshot_file
    Rails.root.join("tmp/#{screenshot_filename}").to_s
  end

  def screenshot_object
    s3 = AWS::S3.new(:s3_endpoint => ENV["AWS_S3_ENDPOINT"])
    bucket = s3.buckets[ENV["AWS_S3_BUCKET"]]
    bucket.objects["screenshots/#{screenshot_filename}"]
  end

  def screenshot_url
    screenshot_object.public_url
  end

  def generate_screenshot
    unless screenshot_object.exists? || File.exist?(temp_screenshot_file)
      screenshot_js = Rails.root.join("vendor/screenshot.js").to_s
      Phantomjs.run(screenshot_js, webpage_request.url, temp_screenshot_file)
    end

    File.exist?(temp_screenshot_file) && upload_screenshot
  end

  def upload_screenshot
    screenshot_object.write(:file => temp_screenshot_file, :acl => :public_read)

    if screenshot_object.exists? 
      if File.exist?(temp_screenshot_file)
        File.delete(temp_screenshot_file)
      end
      screenshot_url
    end
  end
end
