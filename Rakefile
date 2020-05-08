# frozen_string_literal: true

# These tasks are only available in development/test
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task default: %i[spec rubocop]
rescue LoadError # rubocop:disable Lint/SuppressedException
end
