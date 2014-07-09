# Defines helper methods for user step definitions
module UserHelpers
  def create_visitor
    @visitor ||= FactoryGirl.attributes_for(:user)
  end

  def find_user
    @user ||= User.where(
      email:    @visitor[:email],
      username: @visitor[:username]
    ).first
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
    @user ||= User.where(
      email:    @visitor[:email],
      username: @visitor[:username]
    ).first
    @user.destroy if @user.present?
  end

  def sign_up
    delete_user
    visit '/users/sign_up'
    fill_in 'user_email', with: @visitor[:email]
    fill_in 'user_username', with: @visitor[:username]
    fill_in 'user_password', with: @visitor[:password]
    fill_in 'user_password_confirmation', with: @visitor[:password_confirmation]
    click_button 'Sign up'
    find_user
  end

  def sign_in(user_login)
    visit '/users/sign_in'
    fill_in 'user_login', with: user_login
    fill_in 'user_password', with: @visitor[:password]
    click_button 'Sign in'
  end
end

World(UserHelpers)
