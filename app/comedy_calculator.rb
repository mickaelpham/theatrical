# frozen_string_literal: true

class ComedyCalculator < PerformanceCalculator
  def amount
    result = 30_000

    if performance['audience'] > 20
      result += 10_000 + 500 * (performance['audience'] - 20)
    end

    result += 300 * performance['audience']

    result
  end
end
