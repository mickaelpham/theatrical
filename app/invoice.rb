# frozen_string_literal: true

class Invoice
  def self.statement(invoice, plays)
    total_amount = 0
    volume_credits = 0
    result = "Statement for #{invoice['customer']}\n"

    invoice['performances'].each do |perf|
      play = plays[perf['playID']]
      this_amount = 0

      case play['type']
      when 'tragedy'
        this_amount = 40_000
        this_amount += 1_000 * (perf['audience'] - 30) if perf['audience'] > 30

      when 'comedy'
        this_amount = 30_000

        if perf['audience'] > 20
          this_amount += 10_000 + 500 * (perf['audience'] - 20)
        end

        this_amount += 300 * perf['audience']

      else
        raise "unknown type: #{play['type']}"
      end

      # add volume credits
      volume_credits += [perf['audience'] - 30, 0].max

      # add extra credit for every ten comedy attendees
      volume_credits += (perf['audience'] / 5).floor if play['type'] == 'comedy'

      # print line for this order
      result += "  #{play['name']}: #{Money.us_dollar(this_amount).format} "\
                "(#{perf['audience']} seats)\n"

      total_amount += this_amount
    end

    result += "Amount owned is #{Money.us_dollar(total_amount).format}\n"
    result += "You earned #{volume_credits} credits\n"

    result
  end
end
