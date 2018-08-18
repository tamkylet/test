require 'capybara'
require 'capybara/poltergeist'
require 'capybara_process_helper'
require 'capybara-screenshot/rspec'

include CapybaraProcessHelper


# Selenium test driver with Chromium browser
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome, args: ["--disable-infobars"])
# end

# Capybara.configure do |config|
#   config.default_driver = :selenium
#   config.default_max_wait_time = 20
# end

# RSpec.configure do |config|
#   config.before(:each, type: :feature) do
#     Capybara.current_session.driver.browser.manage.window.resize_to(1_800, 800)
#   end
# end

# Poltergeist test driver
Capybara.default_driver = :poltergeist

options = { js_errors: false }
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.configure do |config|
  config.default_max_wait_time = 20
end


# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
