require "minitest/autorun"
require_relative "../lib/board"
require_relative "../lib/player"
require_relative "../lib/computer"

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @board.spaces = ['X', 'X', 'X', '4', '5', '6', '7', '8', '9']
    @player = Player.new("Joe", "X")
    @computer = Computer.new("Comp", "O", @board, @player)
  end

  def test_player_does_have_position
    assert_equal true, @computer.does_player_have_position?(1, 'X')
  end

  def test_player_does_not_have_position
    assert_equal false, @computer.does_player_have_position?(6, 'X')
  end
end
