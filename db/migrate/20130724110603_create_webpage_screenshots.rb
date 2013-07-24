class CreateWebpageScreenshots < ActiveRecord::Migration
  def change
    create_table :webpage_screenshots do |t|
      t.string :filename
      t.belongs_to :webpage_response, index: true

      t.timestamps
    end
  end
end
