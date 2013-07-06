class CreateWebpages < ActiveRecord::Migration
  def change
    create_table :webpages do |t|
      t.string :url

      t.timestamps
    end
  end
end
