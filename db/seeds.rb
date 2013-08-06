# Create roles
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by(name: role)
end

# Create admin user
admin_user = User.find_or_create_by(
  username: 'admin',
  email:    ENV['ADMIN_EMAIL'].dup
)
admin_user.name = ENV['ADMIN_NAME'].dup
admin_user.password = ENV['ADMIN_PASSWORD'].dup
admin_user.confirmed_at = Time.now
admin_user.save
admin_user.add_role :admin

# Create regular user
user = User.find_or_create_by(
  username: 'test_user',
  email:    ENV['USER_EMAIL'].dup
)
user.name = ENV['USER_NAME'].dup
user.password = ENV['USER_PASSWORD'].dup
user.confirmed_at = Time.now
user.save
user.add_role :user
