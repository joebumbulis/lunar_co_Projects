class Judge
  attr_reader :game, :board

  def initialize(game)
    @game = game
    @board = game.board
  end

  def check_for_game_ending_move(player)
    declare_winner(player.name) if win?(player.token)

    finish_game if there_is_no_winner
  end

  def win?(token)
    Board::WINNING_COMBOS.any? do |win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]

      @board.spaces[index_0] == token &&
      @board.spaces[index_1] == token &&
      @board.spaces[index_2] == token
    end
  end

  def there_is_no_winner
     @board.spaces.none?{ |space| space =~ /[1-9]/ }
  end

  def finish_game
     @board.print_board
     Messages.no_winner
     game.try_again
   end

  def declare_winner(name)
    @board.print_board
    Messages.win(name)
    game.try_again
  end
end
