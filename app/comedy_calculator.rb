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

  def volume_credits
    # add extra credit for every ten comedy attendees
    super + (performance['audience'] / 5).floor
  end
end
