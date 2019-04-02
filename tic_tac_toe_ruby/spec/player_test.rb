require "minitest/autorun"
require_relative "../lib/player"
require_relative "../lib/board"
require_relative "../lib/computer"

class PlayerTest < Minitest::Test
  def setup
    @player_one = Player.new("Joe", "X")
    @player_one.moves = ['2']
    @board = Board.new

  end

  def test_that_player_has_a_name
    assert_equal "Joe", @player_one.name
  end

  def test_that_player_has_a_token
    assert_equal "X", @player_one.token
  end

  def test_that_position_is_placed_in_moves
    assert_equal ['2', '5'], @player_one.place_position_in_moves('5')
  end

end
