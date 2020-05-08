# frozen_string_literal: true

class PerformanceCalculator
  attr_accessor :performance, :play

  def initialize(a_performance, a_play)
    @performance = a_performance
    @play = a_play
  end

  def amount
    result = 0

    case play['type']
    when 'tragedy'
      result = 40_000

      if performance['audience'] > 30
        result += 1_000 * (performance['audience'] - 30)
      end

    when 'comedy'
      result = 30_000

      if performance['audience'] > 20
        result += 10_000 + 500 * (performance['audience'] - 20)
      end

      result += 300 * performance['audience']

    else
      raise "unknown type: #{play['type']}"
    end

    result
  end
end
