module Messages
  def self.blank_space
    puts "\n"
  end

  def self.intro_message
    puts "########################################"
    puts "##       Welcome to Tic Tac Toe       ##"
    puts "########################################"
    puts "##              Let's Play            ##"
    puts "##                                    ##"
    puts "##            TIC |  X  | O           ##"
    puts "##            --------------          ##"
    puts "##             X  | TAC | O           ##"
    puts "##            --------------          ##"
    puts "##             O  |  X  | TOE         ##"
    puts "##                                    ##"
    puts "##             built by Joe           ##"
    puts "########################################"
  end

  def self.players_set_up
    puts "How many players, 1 or 2?"
  end

  def self.intro_player_one
    puts "Please introduce player 1:"
  end

  def self.choose_position(name)
    puts "#{name}, choose a position to place your token"

  end

  def self.intro_player_two
    puts "Please introduce player 2:"
  end

  def self.type_yes_or_no
    puts "Please type 'Y' or 'N'."
  end

  def self.thanks
    puts "Thanks for playing. Hope you liked it!\n\n"
  end

  def self.no_winner
    puts "There's no winner. Play again? (Y/N)"
  end

  def self.win(name)
    puts "#{name} WINS!  Play again? (Y/N)"
  end
end
