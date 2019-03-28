require "minitest/autorun"
require_relative "../lib/player"
require_relative "../lib/board"

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new("Joe", "X")
    @player.moves = ['2']
  end

  def test_that_player_has_a_name
    assert_equal "Joe", @player.name
  end

  def test_that_player_has_a_token
    assert_equal "X", @player.token
  end

  def test_that_position_is_placed_in_moves
    assert_equal ['2', '5'], @player.place_position_in_moves('5')
  end

end
