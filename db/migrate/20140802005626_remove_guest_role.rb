class RemoveGuestRole < ActiveRecord::Migration
  def up
    execute <<-SQL
      DELETE FROM users WHERE role = 0
    SQL

    execute <<-SQL
      UPDATE users SET role = 0 WHERE role = 2
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
