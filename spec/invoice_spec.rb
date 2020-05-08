# frozen_string_literal: true

RSpec.describe Invoice do
  let(:invoice) do
    {
      'customer' => 'Lean Startup',
      'performances' => [
        { 'playID' => 'miser', 'audience' => attendees }
      ]
    }
  end

  let(:plays) do
    {
      'miser' => { 'name' => 'The Miser', 'type' => play_type }
    }
  end

  let(:play_type) { 'comedy' }
  let(:attendees) { 2 }

  describe 'statement' do
    context 'with a small audience' do
      let(:want) do
        <<~STATEMENT
          Statement for Lean Startup
            The Miser: $306.00 (#{attendees} seats)
          Amount owned is $306.00
          You earned 0 credits
        STATEMENT
      end

      it 'generates an invoice statement with no credits earned' do
        expect(Invoice.statement(invoice, plays)).to eq(want)
      end
    end

    context 'with a large audience' do
      let(:attendees) { 200 }

      let(:want) do
        <<~STATEMENT
          Statement for Lean Startup
            The Miser: $1,900.00 (#{attendees} seats)
          Amount owned is $1,900.00
          You earned 210 credits
        STATEMENT
      end

      it 'generates the invoice statement with credits earned' do
        expect(Invoice.statement(invoice, plays)).to eq(want)
      end
    end

    context 'when the play is a tragedy with a large audience' do
      let(:play_type) { 'tragedy' }
      let(:attendees) { 300 }

      let(:want) do
        <<~STATEMENT
          Statement for Lean Startup
            The Miser: $3,100.00 (#{attendees} seats)
          Amount owned is $3,100.00
          You earned 270 credits
        STATEMENT
      end

      it 'generates an invoice statement with a different pricing' do
        expect(Invoice.statement(invoice, plays)).to eq(want)
      end
    end

    context 'when the play is of an unknown type' do
      let(:play_type) { 'sci-fi' }

      it 'raises a runtime error' do
        expect { Invoice.statement(invoice, plays) }
          .to raise_error 'unknown type: sci-fi'
      end
    end
  end

  describe 'html_statement' do
    let(:want) do
      <<~HTML
        <h1>Statement for Lean Startup</h1>
        <table>
          <tr>
            <th>play</th>
            <th>seats</th>
            <th>cost</th>
          </tr>
        <tr>
          <td>The Miser</td>
          <td>2</td>
          <td>$306.00</td>
        </tr>
        </table>
        <p>Amount owned is $306.00</p>
        <p>You earned 0 credits</p>
      HTML
    end

    it 'generates an invoice statement in HTML format' do
      expect(Invoice.html_statement(invoice, plays)).to eq(want)
    end
  end
end
