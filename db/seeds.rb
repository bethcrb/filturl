YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by(name: role)
end

user = User.find_or_create_by(email: ENV['ADMIN_EMAIL'].dup)
user.name = ENV['ADMIN_NAME'].dup
user.password = ENV['ADMIN_PASSWORD'].dup
user.confirmed_at = Time.now
user.save
user.add_role :admin
