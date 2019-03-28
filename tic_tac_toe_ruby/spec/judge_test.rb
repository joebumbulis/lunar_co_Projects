require "minitest/autorun"
require_relative "../lib/judge"
require_relative "../lib/player"
require_relative "../lib/game"

class JudgeTest < Minitest::Test
  def setup
    @game = Game.new
    @judge = Judge.new(@game)
    @player = Player.new("Joe", "X")
  end

  def test_that_player_wins
    skip
    assert_equal true, @judge.check_for_win?(@player)
  end

  def test_to_see_if_no_winner
    assert_equal false, @judge.there_is_no_winner
  end
end
