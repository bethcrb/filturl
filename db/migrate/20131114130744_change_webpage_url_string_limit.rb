class ChangeWebpageUrlStringLimit < ActiveRecord::Migration
  def up
    change_column :webpages, :url, :string, limit: 2000
  end

  def down
    change_column :webpages, :url, :string, limit: nil
  end
end
