require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:translated)
  should validate_presence_of(:translated_uid)
  should validate_presence_of(:token)
  should validate_presence_of(:secret)

  setup do
    @user_attrs = {:translated => "guilleiguaran_fr", :translated_uid => "123456",
                   :token => "123456", :secret => "s3cr37"}
    @attrs = @user_attrs.merge(:original => "guilleiguaran", :original_uid => "00000",
                              :lang_from => "es", :lang_to => "en")
    @user = User.create(@attrs)
    GirlFriday::WorkQueue.immediate!
  end

  test "is valid with translated and translated_uid" do
    user = User.new(@user_attrs)
    assert user.valid?
  end

  test "is completed with all attributes" do
    user = User.create(@user_attrs)
    assert !user.completed?

    user.update_attributes(:original => "guilleiguaran", :original_uid => "0000")
    assert !user.completed?

    user.update_attributes(:lang_from => "en", :lang_to => "es")
    assert user.completed?
    assert REDIS.sismember("watching", "0000")
  end

  test "is authenticated and signed up with twitter account using valid credentials" do
    auth = {'uid' => "1234", 'user_info' => {'nickname' => 'guille'},
            'credentials' => {'token' => 'token', 'secret' => 's3cr37'}}
    user = User.authenticate(auth)

    assert user.persisted?
  end

  test "is authenticated and logged in with twitter account using valid credentials" do
    auth = {'uid' => "123456", 'user_info' => {'nickname' => 'guille'},
            'credentials' => {'token' => 'token', 'secret' => 's3cr37'}}

    assert_equal @user, User.authenticate(auth)
  end

  test "isn't authenticate with twitter without valid credentials" do
    user = User.authenticate({})
    assert !user
  end

  test "post tweet" do
    EasyTranslate.expects(:translate).with("Hola", {:from => 'es', :to => 'en'}).returns("Hello")
    Twitter.expects(:update).returns("Hello")

    tweet = @user.tweet("Hola")
    assert_equal "Hello", tweet
  end

  test "is add to watching list when is created" do
    user = User.create(@attrs)
    user.update_attributes(:original_uid => "12345")
    assert REDIS.sismember("watching", "12345")
  end

  test "is remove watching list when is destroyed" do
    user = User.create(@attrs)
    user.update_attributes(:original_uid => "12345")
    assert REDIS.sismember("watching", "12345")

    user.destroy
    assert !REDIS.sismember("watching", "00000")
  end
end
