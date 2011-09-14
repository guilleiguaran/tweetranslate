module UsersHelper
  def link_to_twitter(user)
    link_to("@#{user}", "https://twitter.com/#{user}")
  end
end
