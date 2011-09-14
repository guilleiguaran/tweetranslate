require 'simplecov'
SimpleCov.start 'rails'
SimpleCov.command_name

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "capybara/rails"
Rails.backtrace_cleaner.remove_silencers!
Capybara.default_driver = :rack_test

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...

  def setup
    REDIS.flushdb
  end
end
