require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  test "link_to_twitter create a link to a twitter user account" do
    assert_equal %q(<a href="https://twitter.com/guilleiguaran">@guilleiguaran</a>),
                 link_to_twitter("guilleiguaran")
  end
end
