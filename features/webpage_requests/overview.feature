Feature: Overview
  In order to see the basic information about a URL
  As a user
  I want to see an overview of information about the URL

  Background:
    Given I am logged in
    And I submitted the URL "http://www.example.com/"

  @vcr
  Scenario: User sees IP address
    When I visit the page for the URL "http://www.example.com/"
    Then I should see "IP address"
