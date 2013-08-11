Feature: Screenshots
  As a registered user
  I want to see screenshots of URLs
  So that I can see what a website looks like without visiting it

  Background:
    Given I am logged in
    And I successfully submitted a URL

  @vcr
  Scenario: User clicks on the screenshot tab
    When I click on the screenshot tab
    Then I should see a screenshot of the URL
