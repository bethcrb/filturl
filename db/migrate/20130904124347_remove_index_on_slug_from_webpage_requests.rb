class RemoveIndexOnSlugFromWebpageRequests < ActiveRecord::Migration
  def up
    remove_index :webpage_requests, :slug
  end

  def down
    add_index :webpage_requests, :slug, unique: true
  end
end
