class RemoveIndexFromWebpageUrl < ActiveRecord::Migration
  def up
    remove_index :webpages, :url
  end

  def down
    add_index :webpages, :url, unique: true
  end
end
