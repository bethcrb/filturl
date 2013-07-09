class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :after => :email, :null => false, :default => ""

    add_index :users, :username, :unique => true
    add_index :users, [:email,:username], :name => "login"
  end
end
