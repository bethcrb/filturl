class RemoveSlugFromWebpageRequests < ActiveRecord::Migration
  def change
    remove_column :webpage_requests, :slug, :string
  end
end
