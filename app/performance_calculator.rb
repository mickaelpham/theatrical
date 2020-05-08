# frozen_string_literal: true

class PerformanceCalculator
  attr_accessor :performance, :play

  def initialize(a_performance, a_play)
    @performance = a_performance
    @play = a_play
  end
end
