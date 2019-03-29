class Board
  attr_accessor :spaces

  def initialize
    @spaces = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
  end

  def update_spaces_with_moves(player)
    @spaces.map! do |space|
      player.moves.include?(space) ? player.token : space
    end
  end

  def is_position_available?(input)
    @spaces.include?(input)
  end

  def reset_board
    @spaces = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
  end

  def print_board
    puts "\n"
    puts " ######################################"
    puts " ##                                  ##"
    puts " ##             #{spaces[0]} | #{spaces[1]} | #{spaces[2]}            ##"
    puts " ##          --------------          ##"
    puts " ##             #{spaces[3]} | #{spaces[4]} | #{spaces[5]}            ##"
    puts " ##          --------------          ##"
    puts " ##             #{spaces[6]} | #{spaces[7]} | #{spaces[8]}            ##"
    puts " ##                                  ##"
    puts " ######################################"
    puts "\n"
  end
end
