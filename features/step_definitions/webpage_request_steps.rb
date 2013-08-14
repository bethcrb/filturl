# Stub Phantomjs
Before do
  Screenshot.stub(:needs_update?).and_return(false)
  Phantomjs.stub(:run) do |options, screenshot_js, screenshot_url, temp_file|
     FileUtils.touch(temp_file)
  end
end

### UTILITY METHODS ###
def create_webpage_request
  @webpage_request = FactoryGirl.create(:webpage_request)
end

### GIVEN ###
Given(/^I successfully submitted a URL$/) do
  create_webpage_request
end

### WHEN ###
When(/^I submit a valid URL$/) do
  @valid_webpage_request = FactoryGirl.create(:webpage_request)
  visit '/'
  fill_in 'webpage_request_url', with: @valid_webpage_request.url
  click_button 'Go'
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

When(/^I submit a URL with the wrong content-type$/) do
  @invalid_content_type_request = FactoryGirl.build_stubbed(
    :webpage_request,
    url: 'https://www.filturl.net/logo.png'
  )
  visit '/'
  fill_in 'webpage_request_url', with: @invalid_content_type_request.url
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
  visit webpage_request_path(@valid_webpage_request)
  page.should have_content 'Overview'
end

Then(/^I should see an invalid URL message$/) do
  page.should have_content 'Url is not reachable'
end

Then(/^I should see an invalid content-type message$/) do
  page.should have_content 'Url could not be verified as HTML'
end

Then(/^I should see a screenshot of the URL$/) do
  page.should have_xpath("//img[@src=\"#{@webpage_request.screenshot.url}\"]")
end
