# frozen_string_literal: true

class TragedyCalculator < PerformanceCalculator
  def amount
    result = 40_000

    if performance['audience'] > 30
      result += 1_000 * (performance['audience'] - 30)
    end

    result
  end
end
