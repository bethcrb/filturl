class CreateWebpages < ActiveRecord::Migration
  def change
    create_table :webpages do |t|
      t.string :effective_url, null: false, default: ''
      t.string :primary_ip
      t.text :body, limit: 4294967295

      t.timestamps
    end

    add_index :webpages, :effective_url, unique: true
  end
end
