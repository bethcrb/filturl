class RenameRequestorIdToUserId < ActiveRecord::Migration
  def change
    rename_column :webpage_requests, :requestor_id, :user_id
  end
end
