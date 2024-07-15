# frozen_string_literal: true

module Compare
  def parse_guess
    [check_content, check_position]
  end

  def check_position
    i = 0
    c_pos = 0
    while i <= 6
      c_pos += 1 if @guess[i] == @secret_code[i]
      i += 2
    end
    c_pos
  end

  def check_content
    i = 0
    c_cont = 0
    while i <= 6
      c_cont += 1 if @secret_code.include?(@guess[i])
      i += 2
    end
    c_cont
  end
end
