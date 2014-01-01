class RemoveNameFromAuthentications < ActiveRecord::Migration
  def change
    remove_column :authentications, :name, :string
    remove_column :authentications, :first_name, :string
    remove_column :authentications, :last_name, :string
  end
end
