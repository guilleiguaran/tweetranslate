source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'
gem 'inherited_resources'
gem 'unicorn'
gem 'rake', '0.9.3.beta.1'
gem 'simple_form'

gem 'oa-core', :require => 'omniauth/core'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'redis'
gem 'tweetstream'
gem 'yajl-ruby', :require => 'yajl/json_gem'
gem 'easy_translate'
gem 'girl_friday'
gem 'twitter'
gem 'foreman'
gem 'capistrano'
gem 'git-deploy', :git => 'git://github.com/guilleiguaran/git-deploy.git'

group :development do
  gem 'sqlite3'
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git', :require => 'rails_development_boost'
end

group :production do
  gem 'pg'
  gem 'therubyracer'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.0.rc'
  gem 'coffee-rails', '~> 3.1.0.rc'
  gem 'uglifier-rails', '~> 3.1.0.rc'
end

gem 'jquery-rails'

group :test do
  # Pretty printed test output
  # gem 'turn', :require => false

  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'fakeredis'
  gem 'mocha'
  gem 'simplecov', :require => false
end
