require_relative './board'
require_relative './player'
require_relative './messages'
require_relative './computer'
require_relative './judge'

class Game
  attr_accessor :players, :player1, :player2, :computer, :board

  def initialize
    @board = Board.new
    @judge = Judge.new(self)
    @players = 1
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @computer = Computer.new("Computer", "O", @board, @player1)
  end

  def set_up
    Messages.intro_message
    Messages.blank_space
    choose_numbers_of_players
    introduce_players_names
    play_game
  end

  def choose_numbers_of_players
    Messages.players_set_up
    get_players_input
  end

  def get_players_input
    loop do
      input = get_input

      return self.players = input.to_i if input =~ /^[1-2]$/
    end
  end

  def introduce_players_names
    Messages.intro_player_one
    player1.name = get_input

    if @players > 1
      Messages.intro_player_two
      player2.name = get_input
    end
  end

  def play_game
    loop do
      @board.print_board
      first_turn
      @board.print_board
      second_turn
    end
  rescue Interrupt
    exit_game
  end

  def first_turn
    position = ask_for_position(player1)
    player1.place_position_in_moves(position)
    @board.update_spaces_with_moves(player1)
    @judge.check_for_game_ending_move(player1)
    @computer.remove_win_combos(position)
  end

  def second_turn
    if players == 2
      position = ask_for_position(player2)
      player2.place_position_in_moves(position)
      @board.update_spaces_with_moves(player2)
      @judge.check_for_game_ending_move(player2)
      @computer.remove_win_combos(position)
    else
      @computer.play_turn(@judge)
    end
  end

  def ask_for_position(player)
    Messages.choose_position(player.name)
    get_position_input
  end

  def get_position_input
    loop do
      input = get_input
      if input =~ /[1-9]/
        if @board.is_position_available?(input)
          return input.to_s
        else
          @board.print_board
          puts "#{input} is already taken.\n\n Please choose an open position."
        end
      else
        @board.print_board
       puts "'#{input}' is not a correct position.\n\nPlease choose a position marked by 1 through 9:"
      end
    end
  end

  def try_again
    loop do
      input = get_input

      restart_game if input == "y"
      exit_game if input == "n"

      type_yes_or_no
    end
  end

  def restart_game
    @board.reset_board
    Game.new.set_up
  end

  private

  def get_input
    gets.chomp.downcase
  end

  def exit_game
    system "clear" or system "cls"
    Messages.thanks
    exit
  end

  def type_yes_or_no
    Messages.type_yes_or_no
  end
end
