class Board
  attr_accessor :spaces

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
