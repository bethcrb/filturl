### UTILITY METHODS ###

def create_visitor
  @visitor ||= {
    :name                  => "Testy McUserton",
    :email                 => "example@example.com",
    :username              => "example_user",
    :password              => "changeme",
    :password_confirmation => "changeme",
  }
end

def find_user
  @user ||= User.where(:email => @visitor[:email], :username => @visitor[:username]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email], :username => @visitor[:username]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_username", :with => @visitor[:username]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in_with_email
  visit '/users/sign_in'
  fill_in "user_login", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

def sign_in_with_username
  visit '/users/sign_in'
  fill_in "user_login", :with => @visitor[:username]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in_with_email
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

Given /^I am signed in with provider "([^"]*)"$/ do |provider|
  visit "/users/auth/#{provider.downcase}"
end

### WHEN ###
When /^I sign in with a valid email$/ do
  create_visitor
  sign_in_with_email
end

When /^I sign in with a valid username$/ do
  create_visitor
  sign_in_with_username
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up with an invalid username$/ do
  create_visitor
  @visitor = @visitor.merge(:username => "$notausername")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in_with_email
end

When /^I sign in with a wrong username$/ do
  @visitor = @visitor.merge(:username => "wrong_user")
  sign_in_with_username
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in_with_email
end

When /^I edit my account details$/ do
  visit "/users/edit"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "A message with a confirmation link has been sent to your email address."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Emailis invalid"
end

Then /^I should see an invalid username message$/ do
  page.should have_content "Usernameis invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Passwordcan't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password confirmationdoesn't match"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password confirmationdoesn't match"
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid login or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end
