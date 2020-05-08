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
            The Miser: $1900.00 (#{attendees} seats)
          Amount owned is $1900.00
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
            The Miser: $3100.00 (#{attendees} seats)
          Amount owned is $3100.00
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
        expect { Invoice.statement(invoice, plays) }.
          to raise_error "unknown type: sci-fi"
      end
    end
  end
end
