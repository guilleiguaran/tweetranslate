require 'test_helper'

class TweetranslateTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = {
      'uid' => '123545',
      'user_info' => {'nickname' => 'matz_traducido'},
      'credentials' => {'token' => '70k3n', 'secret' => 's3cr37'}
    }
  end

  test "associate twitter account for translation of tweets" do
    visit '/'
    click_link 'Twitter'
    assert page.has_content?('Signed in')

    fill_in '@', :with => "yukihiro_matz"
    select 'japanese', :from => 'Translate from:'
    select 'spanish', :from => 'Translate to:'
    click_button 'Finish'
    assert page.has_content?('Twitter account is now associated for translations!')
  end

  test "de-associate twitter account" do
    visit '/'
    click_link 'Twitter'
    assert page.has_content?('Signed in')

    click_link 'X'

    assert page.has_content?('Twitter account de-associated')
  end
end
