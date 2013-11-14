class ChangeScreenshotUrlStringLimit < ActiveRecord::Migration
  def up
    change_column :screenshots, :url, :string, limit: 2000
  end

  def down
    change_column :screenshots, :url, :string, limit: nil
  end
end
