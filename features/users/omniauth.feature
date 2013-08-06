Feature: Omniauth
  In order to get access to protected sections of the site
  A user
  Should be able to sign in or sign up through an omniauth provider

  Scenario Outline: Sign in with Omniauth
    Given I am not logged in
    And I am signed in with provider "<Provider>"
    When I return to the site
    Then I should be signed in

    Examples:
      | Provider |
      | facebook |
      | github |
      | google_oauth2 |
