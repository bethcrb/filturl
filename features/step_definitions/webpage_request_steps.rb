# Stub Phantomjs
Before do
  Screenshot.stub(:needs_update?).and_return(false)
  Phantomjs.stub(:run) do |options, screenshot_js, screenshot_url, temp_file|
     FileUtils.touch(temp_file)
  end
end

### GIVEN ###
Given(/^I submitted the URL "(.*?)"$/) do |url|
  @webpage_request = WebpageRequest.create(url:  url, user_id: @user.id)
end

Given(/^the slug "(.*?)" does not exist$/) do |slug|
  assert_nil Webpage.find_by_slug(slug)
end

### WHEN ###
When(/^I submit the URL "(.*?)"$/) do |url|
  fill_in 'webpage_request_url', with: url
  click_button 'Go'
end

When(/^I click on the screenshot tab$/) do
  click_link 'Screenshot'
end

### THEN ###
Then(/^I should see information about the URL$/) do
  page.should have_content 'Overview'
end

Then(/^I should see an invalid URL message$/) do
  page.should have_content 'Url could not be verified'
end

Then(/^I should see a screenshot of the URL "(.*?)"$/) do |url|
  page.should have_xpath("//img[@src=\"#{@webpage_request.screenshot.url}\"]")
end
