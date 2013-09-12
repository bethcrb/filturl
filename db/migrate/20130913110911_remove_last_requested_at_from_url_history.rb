class RemoveLastRequestedAtFromUrlHistory < ActiveRecord::Migration
  def change
    remove_column :url_histories, :last_requested_at, :datetime
  end
end
