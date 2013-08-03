class RenameWebpageScreenshotToScreenshot < ActiveRecord::Migration
  def change
    rename_table :webpage_screenshots, :screenshots
  end
end
