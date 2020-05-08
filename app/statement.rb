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
      PerformanceCalculator.new(a_performance, play_for(a_performance))

    # https://www.thoughtco.com/making-deep-copies-in-ruby-2907749
    result = Marshal.load(Marshal.dump(a_performance))

    result['play'] = calculator.play
    result['amount'] = calculator.amount
    result['volume_credits'] = volume_credits_for(result)

    result
  end

  def self.total_amount(data)
    result = 0

    data['performances'].each do |perf|
      result += perf['amount']
    end

    result
  end

  def self.total_volume_credits(data)
    result = 0

    data['performances'].each do |perf|
      result += perf['volume_credits']
    end

    result
  end

  def self.volume_credits_for(a_performance)
    result = 0

    result += [a_performance['audience'] - 30, 0].max

    # add extra credit for every ten comedy attendees
    if a_performance['play']['type'] == 'comedy'
      result += (a_performance['audience'] / 5).floor
    end

    result
  end
end
