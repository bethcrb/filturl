class RemoveUrlHistories < ActiveRecord::Migration
  def up
    drop_table :url_histories
  end

  def down
    create_table :url_histories do |t|
      t.string :url, limit: 2000
      t.belongs_to :webpage, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
