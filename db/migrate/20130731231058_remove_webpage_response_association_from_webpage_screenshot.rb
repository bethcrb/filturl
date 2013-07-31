class RemoveWebpageResponseAssociationFromWebpageScreenshot < ActiveRecord::Migration
  def change
    remove_reference :webpage_screenshots, :webpage_response, index: true
  end
end
