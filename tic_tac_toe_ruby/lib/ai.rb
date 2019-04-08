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
    @position = check_and_get_necessary_move(@human.token)
    @position = check_and_get_necessary_move(self.token) unless @position
    @position = find_best_open_position unless @position
    @position.to_s
  end

  def find_best_open_position
    open_board_spaces = @board.spaces.select{|space| space.match(/\d/)}

    if one_space_left?(open_board_spaces)
      open_board_spaces.pop()
    end


    check_for_win_combo_position
    # random_move
  end

  def check_for_win_combo_position
    @win_combos_available.map do |combo|
      self.moves.map do |move|
        move_index = move.to_i - 1

        if combo.include?(move_index)
          open_moves = combo.reject{|pos| pos == move}
          return open_moves.pop()
        end
    end
  end


  end

  def check_and_get_necessary_move(token)
    Board::WINNING_COMBOS.each do |win_combo|
      index_0 = win_combo[0]
      index_1 = win_combo[1]
      index_2 = win_combo[2]
      ``
      if does_player_have_position?(index_0, token) && does_player_have_position?(index_1, token)
        # if @board.is_position_available?(index_2)
          @position = index_2 + 1
        # end
      elsif does_player_have_position?(index_0, token) && does_player_have_position?(index_2, token)
        # if @board.is_position_available?(index_1)
          @position = index_1 + 1
        # end
      elsif does_player_have_position?(index_1, token) && does_player_have_position?(index_2, token)
        # if @board.is_position_available?(index_0)
          @position = index_0 + 1
        # end
      end
    end
    return @position
  end

  # def random_move(index = 0)
  #   space = @board.spaces[index]
  #   if @board.is_position_available?(space)
  #     space
  #   else
  #     random_move(index + 1)
  #   end
  # end


  def does_player_have_position?(index, token)
      @board.spaces[index] == token
  end

  def one_space_left?(open_board_spaces)
    if open_board_spaces.length <= 1
      true
    end
  end
end
