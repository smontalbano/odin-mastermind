# frozen_string_literal: true

require_relative 'display'

class Computer
  VALID_GUESS = %w[R O Y G B P].freeze
  CODE_SIZE = 4

  def initialize
    @guess = ''
  end

  def make_guess
    CODE_SIZE.times { @guess += "#{VALID_GUESS[rand(6)]} " }
    @guess.strip!
  end
end
