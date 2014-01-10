class RemoveHttpStatusCodes < ActiveRecord::Migration
  def up
    drop_table :http_status_codes
  end

  def down
    create_table :http_status_codes do |t|
      t.integer :value, index: true, unique: true
      t.string :description, index: true
      t.string :reference

      t.timestamps
    end
  end
end
