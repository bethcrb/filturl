class AddWebpageAssociationToWebpageScreenshot < ActiveRecord::Migration
  def change
    add_reference :webpage_screenshots, :webpage, index: true, after: :url
  end
end
