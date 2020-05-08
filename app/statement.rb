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
    result['amount'] = amount_for(result)
    result['volume_credits'] = volume_credits_for(result)

    result
  end

  def self.total_amount(data)
    result = 0

    data['performances'].each do |perf|
      result += amount_for(perf)
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

  def self.amount_for(a_performance)
    result = 0

    case a_performance['play']['type']
    when 'tragedy'
      result = 40_000

      if a_performance['audience'] > 30
        result += 1_000 * (a_performance['audience'] - 30)
      end

    when 'comedy'
      result = 30_000

      if a_performance['audience'] > 20
        result += 10_000 + 500 * (a_performance['audience'] - 20)
      end

      result += 300 * a_performance['audience']

    else
      raise "unknown type: #{a_performance['play']['type']}"
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
