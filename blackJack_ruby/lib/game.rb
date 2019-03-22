require_relative './messages'

class Game
  # init view - ask if player wants to play - get player name
  # on yes, init deck, player, and dealer
  # deal dealer hand
  # deal player hand

  def initialize()
      @deck_cards = [];
      @players = [];
  end

  def play_game
    initiate_game

  end

  def initiate_game
    Messages.intro
    Messages.blank_space
    ask_to_play
  end

  def  ask_to_play
    puts "Do you want to play? Press Y / N"
    command = gets.chomp
    valid = false

    while(!valid)
      if command == 'Y' or command == 'N'
        valid = true
      else
       puts "Wrong Input, Please press Y or N then ENTER"
        command = gets.chomp
      end
    end

    if command == 'N'
      puts "Bye"
      system "clear"
    elsif command == 'Y'
      run_game
    end
  end

  def run_game
    puts "run the game now"
    # deal cards
    # push card to hand
  end
end
