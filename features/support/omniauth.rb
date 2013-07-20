OmniAuth.config.test_mode = true

OmniAuth.config.add_mock(:facebook, {
  :provider => "facebook",
  :uid      => "12345",
  :extra    => {
    :raw_info => {
      :username => "example_user"
    },
  },
  :info => {
    :name       => "Testy McUserton",
    :email      => "example@example.com",
    :nickname   => "example_user",
    :first_name => "Testy",
    :last_name  => "McUserton",
    :image      => "http://graph.facebook.com/12345/picture?type=square",
  },
})

OmniAuth.config.add_mock(:github, {
  :provider => "github",
  :uid      => "12345",
  :extra => {
    :raw_info   => {
      :login => "example_user"
    },
  },
  :info => {
    :name        => "Testy McUserton",
    :email       => "example@example.com",
    :nickname    => "example_user",
    :location    => "New York, NY",
    :description => "an example user",
    :image       => "https://secure.gravatar.com/avatar/12345?d=https://a12345.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-12345.png",
  },
})

OmniAuth.config.add_mock(:google_oauth2, {
  :provider => "google_oauth2",
  :uid      => "12345",
  :extra    => {
    :raw_info => {
      :id             => "12345",
      :email          => "example@example.com",
      :verified_email => true,
      :name           => "Testy McUserton",
      :given_name     => "Testy",
      :family_name    => "McUserton",
    },
  },
  :info => {
    :name       => "Testy McUserton",
    :email      => "example@example.com",
    :first_name => "Testy",
    :last_name  => "McUserton",
    :image      => nil,
  },
})
