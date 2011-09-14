class TwitterTranslator
  def self.tweet(tweet_info)
    Twitter.configure do |config|
      config.consumer_key = AppConfig['twitter']['consumer_key']
      config.consumer_secret = AppConfig['twitter']['consumer_secret']
      config.oauth_token = tweet_info['token']
      config.oauth_token_secret = tweet_info['secret']
    end
    translated_tweet = self.translate(tweet_info['text'], tweet_info['lang_from'], tweet_info['lang_to'])
    Rails.logger.info("Posting update: #{translated_tweet}")
    Twitter.update(translated_tweet)
  end

  private
  def self.translate(message, from, to)
    t = EasyTranslate.translate(message, :from => from, :to => to)
  end
end
