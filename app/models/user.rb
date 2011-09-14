class User < ActiveRecord::Base
  validates :translated, :presence => true
  validates :translated_uid, :presence => true
  validates :token, :presence => true
  validates :secret, :presence => true
  after_update :add_to_watching
  before_destroy :remove_from_watching

  def self.authenticate(auth)
    credentials = auth['credentials']
    user = self.find_by_translated_uid(auth['uid'])
    if user
      user.update_attributes(:token => credentials['token'], :secret => credentials['secret'],
                             :translated => auth['user_info']['nickname'])
      user
    else
      self.create(:translated => auth['user_info']['nickname'], :translated_uid => auth['uid'],
                  :token => credentials['token'], :secret => credentials['secret'])
    end
  rescue
    nil
  end

  def completed?
    valid? && original.present? && original_uid.present? &&
      lang_from.present? && lang_to.present?
  end

  def tweet(text)
    TWEET_QUEUE.push('text' => text, 'token' => token, 'secret' => secret, 'lang_from' => lang_from, 'lang_to' => lang_to)
  end


  private

  def add_to_watching
    if completed? && !REDIS.sismember("watching", original_uid)
      REDIS.sadd("watching", original_uid)
    end
  end

  def remove_from_watching
    REDIS.srem("watching", original_uid) if REDIS.sismember("watching", original_uid)
  end
end
