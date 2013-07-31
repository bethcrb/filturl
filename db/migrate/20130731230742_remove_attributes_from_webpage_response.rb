class RemoveAttributesFromWebpageResponse < ActiveRecord::Migration
  def change
    remove_column :webpage_responses, :effective_url, :string
    remove_column :webpage_responses, :primary_ip, :string
    remove_column :webpage_responses, :body, :text
  end
end
