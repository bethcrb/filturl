class ChangeWebpageRedirectUrlStringLimit < ActiveRecord::Migration
  def up
    change_column :webpage_redirects, :url, :string, limit: 2000
  end

  def down
    change_column :webpage_redirects, :url, :string, limit: nil
  end
end
