require "minitest/autorun"
require_relative "../lib/board"
require_relative "../lib/player"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @board.spaces = ['X', 'O', '3', '4', '5', '6', '7', '8', '9']
    @player = Player.new("Joe", "X")
    @player.moves = ['1', '4']
  end

  def test_that_board_has_nine_spaces
    assert_equal 9, @board.spaces.length
  end

  def test_board_spaces_update_to_player_moves
    assert_equal ['X', 'O', '3', 'X', '5', '6', '7', '8', '9'], @board.update_spaces_with_moves(@player)
  end

  def test_input_position_availibity_when_taken
    assert_equal false, @board.is_position_available?('1')
  end

  def test_input_position_availibity_when_open
    assert_equal true, @board.is_position_available?('9')
  end

end
