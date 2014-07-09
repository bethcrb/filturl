Feature: Show webpage request results
  As a user
  I want to see the webpage request data for a URL
  So that I can find out information about the URL without visiting it first

  Scenario: User goes to a page for a URL that does not exist
    Given the slug "http-www-notfound-com" does not exist
    When I go to the webpage request page for the slug "http-www-notfound-com"
    Then I should be redirected to the home page

  @vcr
  Scenario: User goes to a page for an existing URL that they did not request
    Given another user submitted the URL "http://www.example.com/"
    When I go to the webpage request page for the slug "http-www-example-com"
    Then I should be on the webpage request page for the slug "http-www-example-com"
