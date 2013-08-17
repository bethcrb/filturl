Feature: Submit URLs
  As a registered user
  I want to be able to submit URLs
  So that I can see more information about them

  Background:
    Given I am logged in
    And I am on the home page

  @vcr
  Scenario: User submits a valid URL
    When I submit the URL "http://www.example.com/"
    Then I should see "http://www.example.com/"
    And I should see "Overview"
    And I should see "HTTP Headers"
    And I should see "View Source"
    And I should see "Screenshot"

  Scenario: User submits an invalid URL
    When I submit the URL "http://not.a.valid.url"
    Then I should see an invalid URL message

  @vcr
  Scenario: User submits a URL with the wrong content-type
    When I submit the URL "https://www.filturl.net/logo.png"
    Then I should see an invalid content-type message
