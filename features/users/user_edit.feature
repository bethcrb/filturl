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

  Scenario: I change my password
    When I change my password
    Then I should see an account edited message

  Scenario: I enter a new password without confirming it
    When I try to change my password without confirming it
    Then I should see a missing password confirmation message

  Scenario: I enter a new password and the confirmation does not match
    When I try to change my password with a mismatched password confirmation
    Then I should see a mismatched password message
