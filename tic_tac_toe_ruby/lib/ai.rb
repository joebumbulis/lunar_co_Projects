require_relative './board'

module AI
  def get_position
    if @human.moves.length <= 1
      first_move
    else
      find_best_position
    end
  end

  def first_move
    num = rand(1..2)
    num == 1 ? random_start_move : no_win_move
  end

  def random_start_move
    first_move = ["1", "2", "4", "5"].shuffle.pop
    return first_move if @board.is_position_available?(first_move)
    random_start_move
  end

  def no_win_move
    first_move = @human.moves.include?("5") ? "1" : "5"
  end

  def find_best_position
    @position = check_for_necessary_move(@human.token)
    @position = check_for_necessary_move(self.token) unless @position
    @position.to_s
  end

  def check_for_necessary_move(token)
    Board::WINNING_COMBOS.each do |win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]

      if does_player_have_position?(index_0, token) && does_player_have_position?(index_1, token)
        @position = index_2 + 1
      elsif does_player_have_position?(index_0, token) && does_player_have_position?(index_2, token)
        @position = index_1 + 1
      elsif does_player_have_position?(index_1, token) && does_player_have_position?(index_2, token)
        @position = index_0 + 1
      end
    end
    return @position
  end

  def does_player_have_position?(index, token)
      @board.spaces[index] == token
  end

end
