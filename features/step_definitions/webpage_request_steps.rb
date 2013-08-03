### UTILITY METHODS ###
def create_webpage_request
  @webpage_request = FactoryGirl.build(:webpage_request)
  VCR.use_cassette('http_www_google_com') do
    @webpage_request.save!
  end
end

### GIVEN ###
Given(/^I successfully submitted a URL$/) do
  create_webpage_request
end

### WHEN ###
When(/^I submit a valid URL$/) do
  @valid_webpage_request = FactoryGirl.build_stubbed(:webpage_request)
  VCR.use_cassette('http_www_google_com') do
    visit '/'
    fill_in 'webpage_request_url', with: @valid_webpage_request.url
    click_button 'Go'
  end
end

When(/^I submit an invalid URL$/) do
  @invalid_webpage_request = FactoryGirl.build_stubbed(
    :webpage_request,
    url: 'http://not.a.valid.url'
  )
  visit '/'
  fill_in 'webpage_request_url', with: @invalid_webpage_request.url
  click_button 'Go'
end

When(/^I click on the screenshot tab$/) do
  visit webpage_request_path(@webpage_request)
  click_link 'Screenshot'
end

When(/^I visit the page for a URL$/) do
  create_webpage_request
  visit webpage_request_path(@webpage_request)
end

### THEN ###
Then(/^I should see information about the URL$/) do
  visit webpage_request_path(WebpageRequest.last)
  page.should have_content 'Overview'
  page.should have_content 'HTTP Headers'
  page.should have_content 'View Source'
  page.should have_content 'Screenshot'
end

Then(/^I should see an invalid URL message$/) do
  page.should have_content 'url is not reachable'
end

Then(/^I should see a screenshot of the URL$/) do
  page.should have_xpath("//img[@src=\"#{@webpage_request.screenshot.url}\"]")
end
