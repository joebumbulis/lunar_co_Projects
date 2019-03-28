class Judge
  attr_reader :game, :board

  WINNING_COMBOS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

  def initialize(game)
    @game = game
    @board = game.board
  end

  def check_for_win?(player)
    WINNING_COMBOS.each do |win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]

      if @board.spaces[index_0] == player.token && @board.spaces[index_1] == player.token && @board.spaces[index_2] == player.token
        declare_winner(player)
        return true
      end
    end

    finish_game if there_is_no_winner
  end

  def there_is_no_winner
     @board.spaces.none?{ |space| space =~ /[1-9]/ }
  end

  def finish_game
     @board.print_board
     Messages.no_winner
     game.try_again
   end

  def declare_winner(player)
    @board.print_board
    Messages.win(player.name)
    game.try_again
  end
end
