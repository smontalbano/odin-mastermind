# frozen_string_literal: true

require_relative 'compare'
require_relative 'computer'
require_relative 'display'
require 'colorize'

class Mastermind
  include Compare

  attr_accessor :secret_code, :guess, :code_master

  CODE_SIZE = 4
  VALID_GUESS = %w[R O Y G B P].freeze
  @winner = ''

  def initialize
    Display.new
    @secret_code = ''
    @guess = ''
    @game_round = 1
    code_maker? ? set_code : generate_code
  end

  def game_loop # rubocop:disable Metrics/MethodLength
    until winner?
      @guess = if @code_master == 'computer'
                 input_colors
               else
                 sleep 5
                 computer = Computer.new
                 computer.make_guess
               end
      Display.update_board(parse_guess, @guess, @game_round)
      @game_round += 1
    end
    puts "#{@winner} win!"
  end

  private

  def winner?
    if @guess == @secret_code
      @winner = @code_master == 'computer' ? 'You' : 'Computer'
      true
    elsif @game_round > 12
      @winner = @code_master
      true
    else
      false
    end
  end

  def code_maker? # rubocop:disable Metrics/MethodLength
    puts "Who should be the code maker? (Type 'me' or 'computer')"
    @code_master = gets.chomp.downcase
    if @code_master == 'me'
      @code_master = 'You'
      true
    elsif @code_master == 'computer'
      false
    else
      puts "Sorry, I didn't get that. Please try again."
      code_maker?
    end
  end

  def generate_code
    CODE_SIZE.times { @secret_code += "#{VALID_GUESS[rand(6)]} " }
    @secret_code.strip!
    Display.create_board
    game_loop
  end

  def set_code
    @secret_code = input_colors
    Display.create_board
    game_loop
  end

  def input_colors
    colors = ''
    i = 1
    while i <= CODE_SIZE
      puts "Enter color #{i}:"
      color = gets.chomp.upcase
      valid?(color) ? colors += "#{color} " : next
      i += 1
    end
    colors.strip
  end

  def valid?(color)
    if VALID_GUESS.include?(color)
      true
    else
      puts 'Invalid color. Please re-enter color.'
      false
    end
  end
end
