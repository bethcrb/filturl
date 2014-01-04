Feature: Screenshots
  As a registered user
  I want to see screenshots of URLs
  So that I can see what a website looks like without visiting it

  @vcr
  Scenario: User sees screenshot
    Given I am logged in
    And I submitted the URL "http://www.example.com/"
    When I go to the webpage page for the URL "http://www.example.com/"
    Then I should see a screenshot of the URL "http://www.example.com/"
