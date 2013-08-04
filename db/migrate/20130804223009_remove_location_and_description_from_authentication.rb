class RemoveLocationAndDescriptionFromAuthentication < ActiveRecord::Migration
  def change
    remove_column :authentications, :location, :string
    remove_column :authentications, :description, :text
  end
end
