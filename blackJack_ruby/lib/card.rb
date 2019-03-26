class Card
  attr_accessor :label, :suit

  def initialize(label, suit)
    @label = label
    @suit = suit
  end

  def output_card
    # puts "The #{@label} of #{@suit}"
    puts ''
    puts '  ___________  '
    puts ' /           \ '
    puts " | #{@label}         | "
    puts ' |           | '
    puts ' |           | '
    puts " |    #{@suit}      | "
    puts ' |           | '
    puts ' |           | '
    puts " |         #{@label} | "
    puts ' \___________/ '
  end
end
