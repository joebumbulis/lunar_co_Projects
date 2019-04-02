require_relative './ai'

class Computer < Player
  include AI
  attr_reader :token

  def initialize(name, token, board, human)
    super(name, token)
    @board = board
    @human = human
  end

  def play_turn(judge)
    puts "Computer's Turn"
    sleep rand(1..2) * 0.5
    position = self.get_position
    self.place_position_in_moves(position)
    @board.update_spaces_with_moves(self)
    judge.check_for_game_ending_move(self)
  end
end
