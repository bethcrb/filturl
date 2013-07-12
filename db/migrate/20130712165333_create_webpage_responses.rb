class CreateWebpageResponses < ActiveRecord::Migration
  def change
    create_table :webpage_responses do |t|
      t.float :app_connect_time
      t.float :connect_time
      t.string :effective_url
      t.boolean :httpauth_avail
      t.float :name_lookup_time
      t.float :pretransfer_time
      t.string :primary_ip
      t.integer :redirect_count
      t.text :body, :limit => 4294967295
      t.integer :code
      t.text :headers
      t.string :return_message
      t.float :start_transfer_time
      t.float :total_time
      t.belongs_to :webpage_request, index: true

      t.timestamps
    end
  end
end
