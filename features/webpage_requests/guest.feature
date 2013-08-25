Feature: Submit URLs as a guest
  As a guest
  I want to be able to submit URLs
  So that I can see more information about them without logging in first

  Background:
    Given I am on the home page
    And I am not logged in

  Scenario: Guest sees CAPTCHA modal
    When I submit the URL "http://www.example.com/"
    Then I should see "Are you human?"

  @vcr
  Scenario: Guest submits CAPTCHA
    When I submit the URL "http://www.example.com/"
    And I click on "Continue"
    Then I should see "http://www.example.com/"
    And I should see "Overview"
    And I should see "HTTP Headers"
    And I should see "View Source"
    And I should see "Screenshot"
