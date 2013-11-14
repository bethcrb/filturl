class ChangeUrlHistoryUrlStringLimit < ActiveRecord::Migration
  def up
    change_column :url_histories, :url, :string, limit: 2000
  end

  def down
    change_column :url_histories, :url, :string, limit: nil
  end
end
