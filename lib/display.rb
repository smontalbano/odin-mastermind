# frozen_string_literal: true

require_relative 'mastermind'

class Display
  def initialize
    title
    info
    @@board = []
  end

  def title
    puts '    __  ___           __                      _           __
   /  |/  /___ ______/ /____  _________ ___  (_)___  ____/ /
  / /|_/ / __ `/ ___/ __/ _ \/ ___/ __ `__ \/ / __ \/ __  /
 / /  / / /_/ (__  ) /_/  __/ /  / / / / / / / / / / /_/ /
/_/  /_/\__,_/____/\__/\___/_/  /_/ /_/ /_/_/_/ /_/\__,_/

'
  end

  def info
    puts "How to play:

    1. Select if you or the computer will be the code maker.
    2. When the code is set, the decoder must guess the color code by selecting 4 colors in any order.
    3. The program will then reveal how many guesses are in the correct location, are the correct color but incorrect location, or are the incorrect location.
          a. Colors are to be entered by their first letter.
          b. Colors are Red, Orange, Yellow, Green, Blue, and Purple.
          c. The right side of the board will tell you if the colors are in the correct spot. Green is correct color and location, red is correct color but incorrect location, and white is incorrect color.
    4. Decoder wins if they guess the code in 12 turns or less. Code maker wins if they stump the guesser after 12 turns.
HAVE FUN!

"
  end

  def self.create_board
    12.times { @@board << ['o o o o', ['.', '.', '.', '.']] }
    display_board
  end

  def self.display_board # rubocop:disable Metrics/AbcSize
    i = 0
    puts ' ___________________'
    while i < 12
      puts "| #{@@board[i][0]} | #{@@board[i][1][0]} #{@@board[i][1][1]} #{@@board[i][1][2]} #{@@board[i][1][3]} |"
      i += 1
    end
    puts '|___________________|'
  end

  def self.update_board(parsed_guess, guess, round)
    colorize_red(parsed_guess[0], round)
    colorize_green(parsed_guess[1], round)
    @@board[round - 1][0] = guess
    display_board
  end

  def self.colorize_red(parsed_guess, round)
    i = 0
    while i < parsed_guess
      @@board[round - 1][1][i] = '.'.colorize(:red)
      i += 1
    end
  end

  def self.colorize_green(parsed_guess, round)
    i = 0
    while i < parsed_guess
      @@board[round - 1][1][i] = '.'.colorize(:green)
      i += 1
    end
  end
end
