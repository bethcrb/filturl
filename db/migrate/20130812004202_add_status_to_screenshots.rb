class AddStatusToScreenshots < ActiveRecord::Migration
  def change
    add_column :screenshots, :status, :string, after: :url, default: 'inactive'
  end
end
