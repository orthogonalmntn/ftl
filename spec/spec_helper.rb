Dir[File.join(__dir__, '..', 'lib', 'helpers', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, '..', 'lib', 'events', '*.rb')].each { |file| require_relative file }
require_relative '../lib/operations/operation'
Dir[File.join(__dir__, '..', 'lib', '**', '*.rb')].each { |file| require_relative file }
require 'pry'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :faraday
  # c.configure_rspec_metadata!
  # to allow you to record cassettes for each it / context blocks
  # do it "test case" :vcr do ...
  # but it creates too many cassettes (one per each block)
end

$stdout = StringIO.new

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:all) do
    ENV["MONGODB_NAME"] = "ftl_db_test"
  end

end
