class AddLastRequestedAtToUserUrlHistories < ActiveRecord::Migration
  def change
    add_column :user_url_histories, :last_requested_at, :datetime, after: :url
  end
end
