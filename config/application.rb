# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

loader = Zeitwerk::Loader.new
loader.push_dir 'app'
loader.setup
