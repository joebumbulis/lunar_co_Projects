require_relative './ai'

class Computer < Player
  def initialize(name, token, board, human)
    super(name, token)
    @board = board
    @ai = AI.new(@board, human, self)
  end

  def play_turn(judge)
    puts "Computer's Turn"
    sleep rand(1..2) * 0.5
    position = @ai.get_position
    self.place_position_in_moves(position)
    @board.update_spaces_with_moves(self)
    judge.check_for_game_ending_move(self)
  end
end
