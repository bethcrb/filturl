def create_webpage_request
  @webpage_request = FactoryGirl.create(:webpage_request)
end

def submit_url
  visit '/'
  fill_in "webpage_request_url", :with => @url
  click_button "Go"
end

Given(/^I successfully submitted a URL$/) do
  create_webpage_request
end

When(/^I click on the screenshot tab$/) do
  visit webpage_request_path(@webpage_request)
  click_link "Screenshot"
end

Then(/^I should see a screenshot of the URL$/) do
  page.should have_xpath("//img[@src=\"#{@webpage_request.webpage_response.screenshot_url}\"]")
end
