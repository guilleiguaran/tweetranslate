require 'test_helper'

class TwitterTranslatorTest < ActiveSupport::TestCase
  test "post a translated message to twitter" do
    EasyTranslate.expects(:translate).with("Hola", {:from => 'es', :to => 'en'}).returns("Hello")
    Twitter.expects(:update).returns("Hello")

    tweet = TwitterTranslator.tweet('text' => 'Hola', 'token' => 'token', 'secret' => 's3cre7',
                                    'lang_from' => 'es', 'lang_to' => 'en')
    assert_equal "Hello", tweet
  end
end
