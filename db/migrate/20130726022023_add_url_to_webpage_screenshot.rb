class AddUrlToWebpageScreenshot < ActiveRecord::Migration
  def change
    add_column :webpage_screenshots, :url, :string, after: :filename
  end
end
