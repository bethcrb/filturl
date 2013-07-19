Feature: Submit URLs
  As a registered user
  I want to be able to submit URLs
  So that I can see more information about them

  Background:
    Given I am logged in

  Scenario: User submits a valid URL
    When I submit a valid URL
    Then I should see information about the URL

  Scenario: User submits an invalid URL
    When I submit an invalid URL
    Then I should see an invalid URL message
