class CreateWebpageRequests < ActiveRecord::Migration
  def change
    create_table :webpage_requests do |t|
      t.string :url, null: false
      t.belongs_to :requestor, :class_name => "User", null: false

      t.timestamps
    end

    add_index :webpage_requests, :url, :unique => true
    add_index :webpage_requests, [ :url, :requestor_id ]
  end
end
