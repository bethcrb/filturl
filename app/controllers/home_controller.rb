# This controller will act as the site root for unauthenticated users.
# It does not currently do anything because the current setup will
# automatically redirect unauthenticated users to the sign in page.
class HomeController < ApplicationController
  def index
  end
end
