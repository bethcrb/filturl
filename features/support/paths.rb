# Maps a name to a path. Used by the
#
#   When /^I go to (.+)$/ do |page_name|
#
# step definition in web_steps.rb
#
module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the sign up page/
      '/users/sign_up'

    when /the sign in page/
      '/users/sign_in'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_type = page_name =~ /the (.*) page/
        if page_type.present?
          path_components = page_type.split(/\s+/)
          send(path_components.push('path').join('_').to_sym)
        end
      rescue Object
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
