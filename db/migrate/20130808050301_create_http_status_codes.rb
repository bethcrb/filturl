class CreateHttpStatusCodes < ActiveRecord::Migration
  def change
    create_table :http_status_codes do |t|
      t.integer :value, index: true, unique: true
      t.string :description, index: true
      t.string :reference

      t.timestamps
    end
  end
end
