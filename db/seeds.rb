# Create admin user
User.find_or_create_by!(username: 'admin', email: ENV['ADMIN_EMAIL'].dup) do |user|
  user.password = ENV['ADMIN_PASSWORD'].dup
  user.confirmed_at = Time.now
  user.admin!
end

# Create regular user
User.find_or_create_by(username: 'test_user', email: ENV['USER_EMAIL'].dup) do |user|
  user.password = ENV['USER_PASSWORD'].dup
  user.confirmed_at = Time.now
  user.user!
end
