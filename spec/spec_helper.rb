require "pry-byebug"
require "pp"

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.warnings = true
  config.order = :random

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if !ENV["CI"]
    config.default_formatter = "doc"
  end

  Kernel.srand config.seed
end

class TestRingItemWrapper < SimpleDelegator; end
