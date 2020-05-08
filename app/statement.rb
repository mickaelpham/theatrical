# frozen_string_literal: true

# frozen_string_literal

class Statement
  def self.create(invoice, plays)
    @plays = plays

    result = {}

    result['customer'] = invoice['customer']

    result['performances'] =
      invoice['performances'].map { enrich_performance(_1) }

    result['total_amount'] = total_amount(result)
    result['total_volume_credits'] = total_volume_credits(result)

    result
  end

  def self.play_for(a_performance)
    @plays ||= []
    @plays[a_performance['playID']]
  end

  def self.enrich_performance(a_performance)
    calculator =
      PerformanceCalculator.of(a_performance, play_for(a_performance))

    # https://www.thoughtco.com/making-deep-copies-in-ruby-2907749
    result = Marshal.load(Marshal.dump(a_performance))

    result.merge(
      'play' => calculator.play,
      'amount' => calculator.amount,
      'volume_credits' => calculator.volume_credits
    )
  end

  def self.total_amount(data)
    data['performances'].inject(0) { |sum, perf| sum + perf['amount'] }
  end

  def self.total_volume_credits(data)
    data['performances'].inject(0) { |sum, perf| sum + perf['volume_credits'] }
  end
end
