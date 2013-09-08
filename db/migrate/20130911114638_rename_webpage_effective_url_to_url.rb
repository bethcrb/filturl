class RenameWebpageEffectiveUrlToUrl < ActiveRecord::Migration
  def change
    rename_column :webpages, :effective_url, :url
  end
end
