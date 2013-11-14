class ChangeWebpageRequestUrlStringLimit < ActiveRecord::Migration
  def up
    change_column :webpage_requests, :url, :string, limit: 2000
  end

  def down
    change_column :webpage_requests, :url, :string, limit: nil
  end
end
