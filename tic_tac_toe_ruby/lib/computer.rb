require_relative './ai'

class Computer < Player
  include AI
  attr_reader :token
  attr_accessor :win_combos_available

  def initialize(name, token, board, human)
    super(name, token)
    @board = board
    @human = human
    @win_combos_available = Board::WINNING_COMBOS.dup
  end

  def remove_win_combos(position)
    position_index = position.to_i - 1

    @win_combos_available.reject! do | combo |
      combo.include?(position_index)
    end
  end

  def play_turn(judge)
    sleep rand(1..2) * 0.5
    position = self.get_position
    self.place_position_in_moves(position)
    @board.update_spaces_with_moves(self)
    judge.check_for_game_ending_move(self)
  end
end
