require_relative '20130704065958_rolify_create_roles'

class ConvertRolifyRolesToUserEnumAttribute < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: 0
    add_index(:users, :role)

    reversible do |dir|
      dir.up do
        # Transfer roles from users_roles to users
        execute <<-SQL
          UPDATE users
            SET role = 1
            WHERE id IN (
              SELECT user_id
              FROM users_roles
              JOIN roles ON(roles.id=users_roles.role_id)
              WHERE name = 'admin'
            )
        SQL
        execute <<-SQL
          UPDATE users
          SET role = 2
          WHERE id IN (
            SELECT user_id
            FROM users_roles
            JOIN roles ON(roles.id=users_roles.role_id)
            WHERE name = 'user'
          )
        SQL
      end
      dir.down do
        raise ActiveRecord::IrreversibleMigration
      end
    end

    revert RolifyCreateRoles
  end
end
