require "minitest/autorun"
require_relative "../lib/board"
require_relative "../lib/player"
require_relative "../lib/computer"

class BoardTest < Minitest::Test

  def setup
    @board_one = Board.new
    @board_one.spaces = ['X', 'X', '3', '4', 'O', 'O', '7', '8', 'X']
    @board_two = Board.new
    @board_two.spaces = ['O', 'X', 'X', 'X', 'X', 'O', 'O', 'O', '9']
    @player = Player.new("Joe", "X")
    @computer_one = Computer.new("Comp", "O", @board_one, @player)
    @computer_two = Computer.new("Comp", "O", @board_two, @player)
  end

  def test_player_does_have_position
    assert_equal true, @computer_one.does_player_have_position?(1, 'X')
  end

  def test_player_does_not_have_position
    assert_equal false, @computer_one.does_player_have_position?(6, 'X')
  end

  def test_check_necessary_human_moves
    skip
    assert_equal 3, @computer_one.check_and_get_necessary_move('X')
  end

  def test_check_necessary_computer_moves
    skip
    assert_equal 4, @computer_one.check_and_get_necessary_move('O')
  end

  def test_board_for_one_remaining_space
    open_board_spaces = @board.spaces.select{|space| space.match(/\d/)}
    assert_equal true , @computer_two.one_space_left?(open_board_spaces)
  end
end
