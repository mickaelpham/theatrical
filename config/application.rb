# frozen_string_literal: true

APP_ENV = ENV['APP_ENV'] || 'production'

require 'bundler/setup'
Bundler.require(:default, APP_ENV)

loader = Zeitwerk::Loader.new
loader.push_dir 'app'
loader.setup

# Configuration for Money gem
Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_UP

# Set and configure the logger
require 'logger'

class App
  class << self
    attr_accessor :logger
  end
end

App.logger = Logger.new STDOUT
App.logger.level = APP_ENV == 'development' ? Logger::DEBUG : Logger::WARN
