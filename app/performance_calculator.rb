# frozen_string_literal: true

class PerformanceCalculator
  def self.of(a_performance, a_play)
    case a_play['type']
    when 'tragedy'
      TragedyCalculator.new(a_performance, a_play)
    when 'comedy'
      ComedyCalculator.new(a_performance, a_play)
    else
      raise "unknown type: #{a_play['type']}"
    end
  end

  attr_accessor :performance, :play

  def initialize(a_performance, a_play)
    @performance = a_performance
    @play = a_play
  end

  def amount
    raise 'subclass responsibility'
  end

  def volume_credits
    result = [performance['audience'] - 30, 0].max

    # add extra credit for every ten comedy attendees
    result += (performance['audience'] / 5).floor if play['type'] == 'comedy'

    result
  end
end
