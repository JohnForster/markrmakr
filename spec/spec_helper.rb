ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'

require_relative '../app.rb'
require_relative './features/web_helpers.rb'
require_relative './reset_database.rb'

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::Console]
)
SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each) do
    reset_database!
  end
end

Capybara.app = MarkrMakr
