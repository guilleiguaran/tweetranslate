# Read configurations
AppConfig ||= YAML.load_file(File.join(Rails.root, 'config', 'app_config.yml'))[Rails.env]

# Omniauth configuration
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, AppConfig['twitter']['consumer_key'], AppConfig['twitter']['consumer_secret']
end

# Easy translate configuration
EasyTranslate.api_key = AppConfig['translate']['key']

# Redis connection
REDIS = Redis.new

# Girl Friday

class ErrorLogger
  def handle(ex)
    Rails.logger.info(ex.message)
  end
end

TWEET_QUEUE = GirlFriday::WorkQueue.new(:tweets, :store => GirlFriday::Store::Redis, :error_handler => ErrorLogger) do |msg|
  TwitterTranslator.tweet(msg)
end
