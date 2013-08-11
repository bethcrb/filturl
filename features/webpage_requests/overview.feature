Feature: Overview
  In order to see the basic information about a URL
  As a user
  I want to see an overview of information about the URL

  Background:
    Given I am logged in
    When I visit the page for a URL

  @vcr
  Scenario: User sees IP address
    Then I should see "IP address"
