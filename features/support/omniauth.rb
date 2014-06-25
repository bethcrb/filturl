OmniAuth.config.test_mode = true

# Fake data for OmniAuth mocks
facebook_uid = rand(10**21).to_s
github_uid = rand(10**6).to_s
google_uid = rand(10**21).to_s
first_name = Faker::Name.first_name
last_name = Faker::Name.last_name
name = "#{first_name} #{last_name}"
username = Faker::Internet.user_name
email = Faker::Internet.email

OmniAuth.config.add_mock(:facebook, {
  provider: 'facebook',
  uid:      facebook_uid,
  extra:    {
    raw_info: {
      username: username
    }
  },
  info: {
    name: "#{first_name} #{last_name}",
    email:      email,
    nickname:   username,
    first_name: first_name,
    last_name:  last_name,
    image:      "http://graph.facebook.com/#{facebook_uid}/picture?type=square"
  }
})

OmniAuth.config.add_mock(:github, {
  provider: 'github',
  uid:      github_uid,
  extra:    {
    raw_info: {
      login: username
    }
  },
  info: {
    name:        name,
    email:       email,
    nickname:    username,
    location:    "#{Faker::AddressUS.city}, #{Faker::AddressUS.state_abbr}",
    description: Faker::Lorem.paragraph,
    image:       'https://secure.gravatar.com/avatar/12345?d=https://a12345.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-12345.png'
  }
})

OmniAuth.config.add_mock(:google_oauth2, {
  provider: 'google_oauth2',
  uid:      google_uid,
  extra:    {
    raw_info: {
      id:             google_uid,
      email:          email,
      verified_email: true,
      name:           name,
      given_name:     first_name,
      family_name:    last_name
    }
  },
  info: {
    name:       name,
    email:      email,
    first_name: first_name,
    last_name:  last_name,
    image:      nil
  }
})
