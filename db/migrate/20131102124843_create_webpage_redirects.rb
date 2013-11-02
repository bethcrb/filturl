class CreateWebpageRedirects < ActiveRecord::Migration
  def change
    create_table :webpage_redirects do |t|
      t.string :url
      t.belongs_to :webpage_response, index: true

      t.timestamps
    end
  end
end
