namespace :tweets do
  desc "Watch the tweets of the associated users"
  task :watch => :environment do
    unless twitter_user = ENV["USER"] && twitter_password = ENV["PASSWORD"]
      fail "You must provide a Twitter username and password. to use Streaming API." +
           "Eg: rake tweets:watch USER=guilleiguaran PASSWORD=pass"
    end

    while
      users_count = REDIS.scard("watching")
      users = REDIS.smembers("watching").to_a.map(&:to_i)

      Rails.logger.info "Watching tweets"
      client = TweetStream::Client.new(twitter_user, twitter_password, :yajl)
      client.follow(*users) do |status|
        begin
          Rails.logger.info "New status: #{status.text}"
          users = User.find_all_by_original_uid(status.user.id_str)
          users.each do |user|
            user.tweet(status.text)
          end
        rescue ; end
        client.stop if users_count != REDIS.scard("watching")
      end
    end

  end
end
