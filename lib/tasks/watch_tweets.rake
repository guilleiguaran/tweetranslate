task :watch_tweets => :environment do
  while true
    users_count = REDIS.scard("watching")
    users = REDIS.smembers("watching").to_a.map(&:to_i)
    puts "Monitoring tweets"
    client = TweetStream::Client.new(AppConfig["twitter"]["user"], AppConfig["twitter"]["password"], :yajl)
    client.follow(*users) do |status|
      begin
        puts "New status: #{status.text}"
        user = User.find_by_original_uid(status.user.id_str)
        if user
          user.tweet(status.text)
          Rails.logger.info("New status: #{status.text}")
        end
      rescue ; end
      client.stop if users_count != REDIS.scard("watching")
    end
  end
end
