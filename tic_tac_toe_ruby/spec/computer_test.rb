require "minitest/autorun"
require_relative "../lib/player"
require_relative "../lib/board"
require_relative "../lib/computer"

class ComputerTest < Minitest::Test
  def setup
    @board = Board.new
    @player_two = Player.new("Joseph", "X")
    @player_two.moves = ['1', '7']
    @computer = Computer.new("Comp", "O", @board, @player_one)
    @computer.moves = ['5']
  end

  def test_player_moves_removes_win_combo
    assert_equal [
        [3, 4, 5],
        [6, 7, 8],
        [1, 4, 7],
        [2, 5, 8],
        [6, 4, 2]
      ],
      @computer.remove_win_combos("1")
  end
end
