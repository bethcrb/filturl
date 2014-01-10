class AddStatusToWebpageRequests < ActiveRecord::Migration
  def change
    add_column :webpage_requests, :status, :string, default: 'new'
  end
end
