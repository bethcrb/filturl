class CreateUserUrlHistories < ActiveRecord::Migration
  def change
    create_table :user_url_histories do |t|
      t.string :url, limit: 500
      t.belongs_to :webpage, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
