# frozen_string_literal: true

RSpec.describe Invoice do
  let(:invoice) do
    {
      'customer' => 'Lean Startup',
      'performances' => [
        { 'playID' => 'miser', 'audience' => 2 }
      ]
    }
  end

  let(:plays) do
    {
      'miser' => { 'name' => 'The Miser', 'type' => 'comedy' }
    }
  end

  describe 'statement' do
    let(:want) do
      <<~STATEMENT
        Statement for Lean Startup
          The Miser: $306.00 (2 seats)
        Amount owned is $306.00
        You earned 0 credits
      STATEMENT
    end

    it 'generates an invoice statement' do
      expect(Invoice.statement(invoice, plays)).to eq(want)
    end
  end
end
