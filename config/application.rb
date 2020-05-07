# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

loader = Zeitwerk::Loader.new
loader.push_dir 'app'
loader.setup

# Configuration for Money gem
Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_UP
