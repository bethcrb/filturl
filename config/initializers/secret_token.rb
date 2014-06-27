# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

require 'securerandom'

# Path to the file where the generated secret_key_base is stored
SECRET_KEY_BASE_FILE = Rails.root.join('.secret_key_base')

# This method generates a random secret_key_base so that
# secret_key_base is kept private if secret_token.rb is
# shared publicly.
def find_or_create_secret_key_base
  unless File.exist? SECRET_KEY_BASE_FILE
    # Generate a new secret_key_base unless the file already exists.
    secret_key_base = SecureRandom.hex(64)
    File.write(SECRET_KEY_BASE_FILE, secret_key_base, perm: 0600)
  end

  # Return the contents of the secret key base file.
  File.read(SECRET_KEY_BASE_FILE).chomp
end

Rails.application.config.secret_key_base = find_or_create_secret_key_base
