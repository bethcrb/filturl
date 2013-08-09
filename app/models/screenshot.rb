# == Schema Information
#
# Table name: screenshots
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  url        :string(255)
#  webpage_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Screenshot < ActiveRecord::Base
  belongs_to :webpage

  has_many :webpage_responses, through: :webpage
  has_many :webpage_requests, through: :webpage_responses

  validates :webpage, presence: true

  before_destroy :delete_screenshot

  def generate_screenshot
    return true if Rails.env.test?

    screenshot_js = Rails.root.join('vendor/screenshot.js').to_s
    Phantomjs.run('--ignore-ssl-errors=yes',
                  screenshot_js,
                  webpage.effective_url,
                  temp_screenshot_file
    )

    File.exist?(temp_screenshot_file)
  end

  def upload_screenshot
    if File.exist?(temp_screenshot_file)
      screenshot_object.write(file: temp_screenshot_file, acl: :public_read)
      if screenshot_object.exists?
        self.update_attributes!(url: screenshot_object.public_url.to_s)
        File.delete(temp_screenshot_file)
      end
    end

    screenshot_object.exists?
  end

  def delete_screenshot
    File.delete(temp_screenshot_file) if File.exist?(temp_screenshot_file)
    screenshot_object.delete if screenshot_object.exists?
  end

  protected

  def set_filename
    if filename.nil?
      effective_url = webpage.effective_url
      temp_filename = "#{effective_url.parameterize('_')}.png"
      self.update_attributes!(filename: temp_filename)
    end
  end

  def temp_screenshot_file
    screenshot_dir = Rails.root.join('tmp/screenshots').to_s
    FileUtils.mkdir_p screenshot_dir unless Dir.exists?(screenshot_dir)
    set_filename if filename.blank?
    "#{screenshot_dir}/#{filename}"
  end

  private

  def screenshot_object
    s3 = AWS::S3.new(s3_endpoint: ENV['AWS_S3_ENDPOINT'])
    bucket = s3.buckets[ENV['AWS_S3_BUCKET']]
    bucket.objects["screenshots/#{filename}"]
  end
end
