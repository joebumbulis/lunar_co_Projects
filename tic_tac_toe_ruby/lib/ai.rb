require_relative './board'

class AI
  attr_accessor :players, :player1, :computer, :board

  def initialize(board, human, computer)
    @board = board
    @human = human
    @computer = computer
  end

  def get_position
    if @human.moves.length <= 1
      first_move
    else
      find_best_position
    end
  end

  def first_move
    num = rand(1..2)
    move = num == 1 ? random_start_move : no_win_move
  end

  def random_start_move
    first_move = ["1", "2", "4", "5"].shuffle.pop
    return first_move if @board.is_position_available?(first_move)
    random_start_move
  end

  def no_win_move
    first_move = @human.moves.include?("5") ? "1" : "5"
  end
end
