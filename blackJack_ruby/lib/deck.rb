require_relative './card'

class Deck
  attr_accessor :cards

  def initialize
    @labels = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    @suits = ['♦️', '♠️', '♥️', '♣️']
    @cards = []

    @labels.each do |label|
      @suits.each do |suit|
        @cards << Card.new(label, suit)
      end
    end
  end
end
