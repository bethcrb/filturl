class ChangeDefaultScreenshotStatusToNew < ActiveRecord::Migration
  def change
    change_column :screenshots, :status, :string, default: 'new'
  end
end
