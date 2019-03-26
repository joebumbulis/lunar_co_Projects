require_relative './messages'

class Player
  attr_accessor :hand

  def initialize
    @hand = []
    @bust_value = 21
  end

  def deal(deck_cards, number)
    number.times {@hand << deck_cards.cards.shift}
  end

  def render_deal(is_hidden = false)
    if is_hidden
      Messages.hiddenCard
      puts "#{@hand.last.output_card}"
    else
      hand.each do |card|
        puts "#{card.output_card}"
      end
    end
  end

  def check_for_bust
    get_hand_total_value > @bust_value ? true : false;
  end

  def get_hand_total_value
    total = 0;
    points = convert_labels_to_points_except_aces(@hand)

    points.each { |value|
      if value == "A"
        total += 11
        if total > 21
          total -= 10
        end
      else
        total += value
      end
    }

    return total
  end

  def convert_labels_to_points_except_aces(hand)
    points = hand.map { |card|
      if card.label == 'A'
        'A'
      elsif card.label === 'J' || card.label === 'Q' || card.label === 'K'
        10
      else
        card.label.to_i
      end
    }

  end

end
