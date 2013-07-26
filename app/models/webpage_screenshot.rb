# == Schema Information
#
# Table name: webpage_screenshots
#
#  id                  :integer          not null, primary key
#  filename            :string(255)
#  url                 :string(255)
#  webpage_response_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class WebpageScreenshot < ActiveRecord::Base
  belongs_to :webpage_response

  has_one :webpage_request, through: :webpage_response

  after_create :generate_screenshot
  after_create :upload_screenshot

  before_destroy :delete_screenshot

  protected

  def generate_screenshot
    set_filename if filename.blank?
    screenshot_js = Rails.root.join('vendor/screenshot.js').to_s

    Phantomjs.run('--ignore-ssl-errors=yes',
                  screenshot_js,
                  webpage_request.url,
                  temp_screenshot_file
    )
  end

  def upload_screenshot
    if File.exist?(temp_screenshot_file)
      screenshot_object.write(file: temp_screenshot_file, acl: :public_read)

      if screenshot_object.exists?
        File.delete(temp_screenshot_file)
        self.update_attributes!(url: screenshot_object.public_url.to_s)
      end
    end
  end

  def delete_screenshot
    screenshot_object.delete
  end

  private

  def screenshot_object
    s3 = AWS::S3.new(s3_endpoint: ENV['AWS_S3_ENDPOINT'])
    bucket = s3.buckets[ENV['AWS_S3_BUCKET']]
    bucket.objects["screenshots/#{filename}"]
  end

  def set_filename
    self.update_attributes!(filename: "#{SecureRandom.urlsafe_base64}.png")
  end

  def temp_screenshot_file
    Rails.root.join("tmp/#{filename}").to_s
  end
end
