Feature: Submit URLs
  As a registered user
  I want to be able to submit URLs
  So that I can see more information about them

  Background:
    Given I am on the home page
    And I am logged in

  @vcr
  Scenario: User submits a valid URL
    When I fill in the URL "http://www.example.com/"
    And I click on "Go"
    Then I should be on the webpage request page for the slug "http-www-example-com"
    And I should see "http://www.example.com/"
    And I should see "Overview"
    And I should see "HTTP Headers"
    And I should see "View Source"
    And I should see "Screenshot"

  Scenario: User submits an invalid URL
    When I fill in the URL "http://not.a.valid.url"
    And I click on "Go"
    Then I should be on the home page
    And I should see "Url returned an error"

  @vcr
  Scenario: User submits a valid URL with spaces in it
    When I fill in the URL "http:// www.example.com"
    And I click on "Go"
    Then I should be on the webpage request page for the slug "http-www-example-com"

  Scenario: User submits a URL with a colon and no slashes
    When I fill in the URL "http:www.example.com"
    And I click on "Go"
    Then I should be on the home page
    And I should see "Url returned an error"
