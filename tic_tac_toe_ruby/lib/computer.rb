class Computer < Player
  def initialize(name, token, board)
    super(name, token)
    @board = board
    # @ai = AI.new
  end

  def play_turn
    puts "Computer's Turn"
    sleep rand(1..2) * 0.5
    # position = @ai.
    self.place_position_in_moves(position)
    @board.update_spaces_with_moves(self)
  end
end
