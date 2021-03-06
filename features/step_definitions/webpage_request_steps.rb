# Stub Phantomjs
Before do
  allow(Screenshot).to receive(:needs_update?).and_return(false)
  allow(Phantomjs).to receive(:run) do |*args, screenshot_js, screenshot_url, temp_file|
    FileUtils.touch(temp_file)
  end
end

### GIVEN ###
Given(/^I submitted the URL "(.*?)"$/) do |url|
  @webpage_request = WebpageRequest.create(url:  url, user_id: @user.id)
  WebpageService.perform_http_request(@webpage_request)
end

Given(/^the slug "(.*?)" does not exist$/) do |slug|
  existing_slug = WebpageRequest.find_by(slug: slug)
  existing_slug.destroy if existing_slug.present?
end

Given(/^another user submitted the URL "(.*?)"$/) do |url|
  @another_user = FactoryGirl.create(:user)
  @another_webpage_request = WebpageRequest.create(
    url:  url,
    user_id: @another_user.id
  )
  WebpageService.perform_http_request(@another_webpage_request)
end

### WHEN ###
When(/^I fill in the URL "(.*?)"$/) do |url|
  fill_in 'webpage_request_url', with: url
end

When(/^I click on the screenshot tab$/) do
  click_link 'Screenshot'
end

### THEN ###
Then(/^I should see information about the URL$/) do
  expect(page).to have_content 'Overview'
end

Then(/^I should see an invalid URL message$/) do
  expect(page).to have_content 'Url returned an error'
end

Then(/^I should see a screenshot of the URL "(.*?)"$/) do |url|
  expect(page).to have_xpath("//img[@src=\"#{@webpage_request.screenshot_url}\"]")
end
