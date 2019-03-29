require "minitest/autorun"
require_relative "../lib/judge"
require_relative "../lib/player"
require_relative "../lib/game"

class JudgeTest < Minitest::Test
  def setup
    @game = Game.new
    @board = @game.board
    @board.spaces = ['X', 'X', 'X', '4', '5', '6', '7', '8', '9']
    @judge = Judge.new(@game)
    @player = Player.new("Joe", "X")
    @playerLose = Player.new("loser", "0")
  end

  def test_that_player_wins
    assert_equal true, @judge.win?(@player.token)
  end

  def test_that_player_loses
    assert_equal false, @judge.win?(@playerLose.token)
  end

  def test_to_see_if_no_winner
    assert_equal false, @judge.there_is_no_winner
  end
end
