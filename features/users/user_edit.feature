Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  so I can change my name

  Background:
    Given I am logged in

  Scenario: I change my name
    When I change my name
    Then I should see an account edited message

  Scenario: I change my username to "valid_username"
    When I change my username to "valid_username"
    Then I should see an account edited message

  Scenario: I try to change my username to "$invalid_username"
    When I change my username to "$invalid_username"
    Then I should see an invalid username message
