class Player
  attr_accessor :name, :token, :moves

  def initialize(name, token)
    @name = name
    @token = token
    @moves = [];
  end

  def place_position_in_moves(position)
    @moves << position
  end
end
