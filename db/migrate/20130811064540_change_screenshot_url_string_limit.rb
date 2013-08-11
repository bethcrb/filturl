class ChangeScreenshotUrlStringLimit < ActiveRecord::Migration
  def change
    change_column :screenshots, :url, :string, limit: 500
  end
end
