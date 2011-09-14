# Tweetranslate
This application translate the tweets of the associated users and
publish those to the associated accounts (a la @matz_translated)


## Getting started

Run bootstrap setup rake task. This will install dependencies using Bundler, create database,
migrate tables and load seed data:

    rake setup


Start redis-server. You can install redis easily with Brew: ```brew install redis```

    redis-server


Run the application and the rake task for watch the tweets of the associated users:

    bundle exec foreman start
