@wip
Feature: Show User
  As a registered user of the website
  I want to view my user page
  so I can view my information

  Scenario: User is not logged in
    Given I am not logged in
    When I view my user page
    Then I should be on the sign in page

  Scenario: User views own user page
    Given I am logged in
    When I view my user page
    Then I should see my information

  Scenario: User is not an admin and views another user's page
    Given I am logged in
    And I am not an admin
    When I view another user's page
    Then I should not see their information

  Scenario: User is an admin and view another user's page
    Given I am logged in
    And I am an admin
    When I view another user's page
    Then I should see their information
