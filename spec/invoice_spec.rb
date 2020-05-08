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
      'miser' => { 'name' => 'The Miser', 'type' => 'comedy' }
    }
  end

  describe 'statement' do
    context 'without credits earned' do
      let(:attendees) { 2 }

      let(:want) do
        <<~STATEMENT
          Statement for Lean Startup
            The Miser: $306.00 (#{attendees} seats)
          Amount owned is $306.00
          You earned 0 credits
        STATEMENT
      end

      it 'generates an invoice statement with 0 credits' do
        expect(Invoice.statement(invoice, plays)).to eq(want)
      end
    end

    context 'with credits earned' do
      let(:attendees) { 200 }

      let(:want) do
        <<~STATEMENT
          Statement for Lean Startup
            The Miser: $1900.00 (#{attendees} seats)
          Amount owned is $1900.00
          You earned 210 credits
        STATEMENT
      end

      it 'generates the invoice statement with 210 credits' do
        expect(Invoice.statement(invoice, plays)).to eq(want)
      end
    end
  end
end
