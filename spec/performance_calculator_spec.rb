# frozen_string_literal: true

RSpec.describe PerformanceCalculator do
  let(:an_instance) { described_class.new(a_performance, a_play) }
  let(:a_performance) { nil }
  let(:a_play) { nil }

  describe 'amount' do
    it 'raises an error' do
      expect { an_instance.amount }.to raise_error 'subclass responsibility'
    end
  end
end
