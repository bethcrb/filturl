Feature: Submit URLs
  As a registered user
  I want to be able to submit URLs
  So that I can see more information about them

  Background:
    Given I am on the home page
    And I am logged in

  @vcr
  Scenario: User submits a valid URL
    When I submit the URL "http://www.example.com/"
    Then I should see "http://www.example.com/"
    And I should see "Overview"
    And I should see "HTTP Headers"
    And I should see "View Source"
    And I should see "Screenshot"

  @vcr
  Scenario: User submits an invalid URL
    When I submit the URL "http://not.a.valid.url"
    Then I should see an invalid URL message
