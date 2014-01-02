class AddContentTypeAndMetaEncodingToWebpages < ActiveRecord::Migration
  def change
    add_column :webpages, :content_type, :string
    add_column :webpages, :meta_encoding, :string
  end
end
