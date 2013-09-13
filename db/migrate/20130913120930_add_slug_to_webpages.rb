class AddSlugToWebpages < ActiveRecord::Migration
  def change
    add_column :webpages, :slug, :string, after: :url

    add_index :webpages, :slug, unique: true
  end
end
