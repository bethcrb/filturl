class MoveSlugFromWebpagesToWebpageRequests < ActiveRecord::Migration
  def change
    remove_index :webpages, column: :slug, unique: true
    remove_column :webpages, :slug, :string, after: :url
    add_column :webpage_requests, :slug, :string, after: :url
    add_index :webpage_requests, :slug, unique: true
  end
end
