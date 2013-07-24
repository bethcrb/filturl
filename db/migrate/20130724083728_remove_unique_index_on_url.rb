class RemoveUniqueIndexOnUrl < ActiveRecord::Migration
  def change
    remove_index :webpage_requests, :url
  end
end
