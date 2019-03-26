module Messages
  def self.blank_space
    puts "\n"
  end

  def self.intro
    puts "########################################"
    puts "##        Welcome to BlackJack!       ##"
    puts "##          a cli ruby game           ##"
    puts "##          built by Joe              ##"
    puts "########################################"
  end

  def self.wrong_play_input
    puts "Wrong Input, Please press Y or N then ENTER"
  end

  def self.dealerHandMessage
    puts "DEALER HAND:"
  end

  def self.playerHandMessage
    puts "PLAYER HAND:"
  end

  def self.hiddenCard
    puts "The ? of ?"
  end

  def self.participant_bust_message
    puts "You LOSE: you went over 21"
    puts "YOU BUSTED"
  end

  def self.dealer_bust_message
    puts "You WIN: the dealer went over 21"
    puts "DEALER BUSTED"
  end

  def self.dealer_wins_message
    puts "Dealer beat your total"
    puts "YOU LOSE"
  end

  def self.play_message
    puts "Do you want to play? Press Y / N"
  end
end
