Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in with a valid email
    Then I see an invalid login message
    And I should be signed out

  Scenario: User signs in successfully with email address
    Given I exist as a user
    And I am not logged in
    When I sign in with a valid email
    And I return to the site
    Then I should be signed in

  Scenario: User enters wrong email
    Given I exist as a user
    And I am not logged in
    When I sign in with a wrong email
    Then I see an invalid login message
    And I should be signed out

  Scenario: User signs in successfully with username
    Given I exist as a user
    And I am not logged in
    When I sign in with a valid username
    And I return to the site
    Then I should be signed in

  Scenario: User enters wrong username
    Given I exist as a user
    And I am not logged in
    When I sign in with a wrong username
    Then I see an invalid login message
    And I should be signed out

  Scenario: User signs in successfully with Facebook
    Given I am not logged in
    And I am signed in with provider "facebook"
    When I return to the site
    Then I should be signed in

  Scenario: User signs in successfully with GitHub
    Given I am not logged in
    And I am signed in with provider "github"
    When I return to the site
    Then I should be signed in

  Scenario: User signs in successfully with Google
    Given I am not logged in
    And I am signed in with provider "google_oauth2"
    When I return to the site
    Then I should be signed in

  Scenario: User enters wrong password
    Given I exist as a user
    And I am not logged in
    When I sign in with a wrong password
    Then I see an invalid login message
    And I should be signed out
