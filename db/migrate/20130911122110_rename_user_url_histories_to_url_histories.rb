class RenameUserUrlHistoriesToUrlHistories < ActiveRecord::Migration
  def change
    rename_table :user_url_histories, :url_histories
  end
end
