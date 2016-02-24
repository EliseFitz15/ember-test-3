ENV["RACK_ENV"] ||= "test"

require_relative "../app"
require "rspec"
require "sinatra/activerecord"
require "capybara/poltergeist"
require "rack/test"
require "capybara/rspec"
require "shoulda-matchers"
require "pry"

spec_support_files = File.join(App.settings.root, "spec", "support", "**", "*.rb")
Dir[spec_support_files].each { |file| require file }
Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/seeders/*.rb"].each { |file| require file }

ActiveRecord::Base.logger.level = 1

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random

  config.before(:each) do
    Book.destroy_all
    Review.destroy_all
  end
end

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

include Rack::Test::Methods

def app
  Sinatra::Application
end
