class AddSlugToWebpageRequests < ActiveRecord::Migration
  def change
    add_column :webpage_requests, :slug, :string, after: :url

    add_index :webpage_requests, :slug, unique: true
  end
end
