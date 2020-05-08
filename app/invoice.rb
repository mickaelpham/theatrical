# frozen_string_literal: true

class Invoice
  def self.statement(invoice, plays)
    render_plain_text(Statement.create(invoice, plays))
  end

  def self.render_plain_text(data)
    result = "Statement for #{data['customer']}\n"

    data['performances'].each do |perf|
      # print line for this order
      result += "  #{perf['play']['name']}: " \
                "#{usd(perf['amount'])} "\
                "(#{perf['audience']} seats)\n"
    end

    result += "Amount owned is #{usd(data['total_amount'])}\n"
    result += "You earned #{data['total_volume_credits']} credits\n"

    result
  end

  def self.usd(a_number)
    Money.us_dollar(a_number).format
  end
end
