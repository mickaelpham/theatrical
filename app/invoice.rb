# frozen_string_literal: true

class Invoice
  def self.statement(invoice, plays)
    @plays = plays

    total_amount = 0
    volume_credits = 0
    result = "Statement for #{invoice['customer']}\n"

    invoice['performances'].each do |perf|
      this_amount = amount_for(perf)

      # add volume credits
      volume_credits += [perf['audience'] - 30, 0].max

      # add extra credit for every ten comedy attendees
      if play_for(perf)['type'] == 'comedy'
        volume_credits += (perf['audience'] / 5).floor
      end

      # print line for this order
      result += "  #{play_for(perf)['name']}: " \
                "#{Money.us_dollar(this_amount).format} "\
                "(#{perf['audience']} seats)\n"

      total_amount += this_amount
    end

    result += "Amount owned is #{Money.us_dollar(total_amount).format}\n"
    result += "You earned #{volume_credits} credits\n"

    result
  end

  def self.play_for(a_performance)
    @plays ||= []
    @plays[a_performance['playID']]
  end

  def self.amount_for(a_performance)
    result = 0

    case play_for(a_performance)['type']
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
      raise "unknown type: #{play_for(a_performance)['type']}"
    end

    result
  end
end
