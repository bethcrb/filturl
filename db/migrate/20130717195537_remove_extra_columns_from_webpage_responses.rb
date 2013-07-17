class RemoveExtraColumnsFromWebpageResponses < ActiveRecord::Migration
  def change
    remove_column :webpage_responses, :app_connect_time, :float
    remove_column :webpage_responses, :connect_time, :float
    remove_column :webpage_responses, :httpauth_avail, :boolean
    remove_column :webpage_responses, :name_lookup_time, :float
    remove_column :webpage_responses, :pretransfer_time, :float
    remove_column :webpage_responses, :return_message, :string
    remove_column :webpage_responses, :start_transfer_time, :float
    remove_column :webpage_responses, :total_time, :float
  end
end
