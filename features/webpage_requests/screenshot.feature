Feature: Screenshots
  As a registered user or a guest
  I want to see screenshots of URLs
  So that I can see what a website looks like without visiting it

  Background:
    Given I am logged in
    And I submitted the URL "http://www.example.com/"

  @vcr
  Scenario: User clicks on the screenshot tab
    When I visit the page for the URL "http://www.example.com/"
    And I click on the screenshot tab
    Then I should see a screenshot of the URL "http://www.example.com/"
