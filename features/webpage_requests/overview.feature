Feature: Overview
  As a registered user or a guest
  I want to see an overview with basic information about the URL
  So that I can find out more about the URL without visiting it first

  Background:
    Given I am logged in
    And I submitted the URL "http://www.example.com/"

  @vcr
  Scenario: User sees IP address
    When I visit the page for the URL "http://www.example.com/"
    Then I should see "IP address"
