# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'active_record'
require 'paper_trail'
require 'simple_token_authentication'
require 'devise/orm/active_record'
require 'kaminari'
require 'active_model_serializers'
require 'active_job'
require 'strong_struct'


[
].each do |file|
  require file
end

Dir['./app/models/concerns/**/*.*'].sort.each do |file|
  require file
end

Dir['./app/models/**/*.*'].sort.each do |file|
  require file
end

Dir['./app/commands/**/*.*'].sort.each do |file|
  require file
end

Dir['./app/services/**/*.*'].sort.each do |file|
  require file
end

Dir['./app/jobs/**/*.*'].sort.each do |file|
  require file
end

Dir['./spec/support/unit/**/*.*'].sort.each do |file|
  require file
end


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.disable_monkey_patching!

  config.backtrace_exclusion_patterns << %r|/\.rvm/|
  config.backtrace_exclusion_patterns << %r|/\.gems/|

  config.order = :random
  Kernel.srand config.seed
end
