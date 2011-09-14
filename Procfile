web: bundle exec unicorn -E production -p $PORT -c ./config/unicorn.rb
worker: bundle exec rake watch_tweets RAILS_ENV=production
