### UTILITY METHODS ###
def new_webpage_request
  @webpage_request_attrs = {
    :url => "http://www.google.com",
    :user_id => 1,
  }
end

def create_webpage_request
  VCR.use_cassette("webpage_requests/create_webpage_request") do
    new_webpage_request
    @webpage_request = WebpageRequest.create!(@webpage_request_attrs)
  end
end

def submit_valid_url
  VCR.use_cassette("webpage_requests/submit_valid_url") do
    visit '/'
    fill_in "webpage_request_url", :with => @webpage_request_attrs[:url]
    click_button "Go"
  end
end

def submit_invalid_url
  visit '/'
  fill_in "webpage_request_url", :with => @webpage_request_attrs[:url]
  click_button "Go"
end

### GIVEN ###
Given(/^I successfully submitted a URL$/) do
  create_webpage_request
end

### WHEN ###
When(/^I submit a valid URL$/) do
  new_webpage_request
  submit_valid_url
end

When(/^I submit an invalid URL$/) do
  new_webpage_request
  @webpage_request_attrs = @webpage_request_attrs.merge(:url => "http://not.a.valid.url")
  submit_invalid_url
end

When(/^I click on the screenshot tab$/) do
  visit webpage_request_path(@webpage_request)
  find('#screenshot_tab').click
end

When(/^I visit the page for a URL$/) do
  create_webpage_request
  visit webpage_request_path(@webpage_request)
end

### THEN ###
Then(/^I should see information about the URL$/) do
  visit webpage_request_path(WebpageRequest.last)
  page.should have_content "Overview"
  page.should have_content "HTTP Headers"
  page.should have_content "View Source"
  page.should have_content "Screenshot"
end

Then(/^I should see an invalid URL message$/) do
  page.should have_content "url must be a valid URL"
end

Then(/^I should see a screenshot of the URL$/) do
  page.should have_xpath("//img[@src=\"#{@webpage_request.webpage_response.screenshot_url}\"]")
end

Then(/^I should see an IP address$/) do
  pending # express the regexp above with the code you wish you had
end