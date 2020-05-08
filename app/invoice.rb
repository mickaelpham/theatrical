# frozen_string_literal: true

class Invoice
  def self.statement(invoice, plays)
    render_plain_text(Statement.create(invoice, plays))
  end

  def self.html_statement(invoice, plays)
    render_html(Statement.create(invoice, plays))
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

  def self.render_html(data)
    result = <<~HTML
      <h1>Statement for #{data['customer']}</h1>
      <table>
        <tr>
          <th>play</th>
          <th>seats</th>
          <th>cost</th>
        </tr>
    HTML

    data['performances'].each do |perf|
      result += <<~HTML
        <tr>
          <td>#{perf['play']['name']}</td>
          <td>#{perf['audience']}</td>
          <td>#{usd(perf['amount'])}</td>
        </tr>
      HTML
    end

    result += <<~HTML
      </table>
      <p>Amount owned is #{usd(data['total_amount'])}</p>
      <p>You earned #{data['total_volume_credits']} credits</p>
    HTML

    result
  end

  def self.usd(a_number)
    Money.us_dollar(a_number).format
  end
end
