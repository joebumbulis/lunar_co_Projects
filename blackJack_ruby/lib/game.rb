require_relative './messages'
require_relative './deck'
require_relative './player'

class Game
  def initialize
      @deck_cards = Deck.new
      @dealer = Player.new
      @participant = Player.new
  end

  def play_game
    initiate_game
  end

  def initiate_game
    Messages.intro
    Messages.blank_space
    ask_to_play
  end

  def ask_to_play
    Messages.play_message
    command = get_input
    valid = false

    while(!valid)
      if command == 'Y' or command == 'N'
        valid = true
      else
        Messages.wrong_play_input
        command = get_input
      end
    end

    if command == 'N'
      system "clear"
    elsif command == 'Y'
      run_game
    end
  end

  def run_game
    @deck_cards.cards.shuffle!
    @dealer.deal(@deck_cards, 2)
    @participant.deal(@deck_cards, 2)

    play_round
  end

  def play_round
    render_hands(true)
    participant_turn
  end


  def render_hands(is_hidden = false)
    Messages.dealerHandMessage
    if is_hidden
      @dealer.render_deal(true)
    else
      @dealer.render_deal
    end
    Messages.playerHandMessage
    @participant.render_deal
  end

  def participant_turn
    Messages.hit_or_stay
    command = get_input
    valid = false

    while(!valid)
      if command == "H" or command == "S"
        valid = true
      else
       Messages.wrong_turn_input
       command = get_input
      end
    end

    if command == "H"
      hit
    elsif command == "S"
      dealers_turn
    end
  end

  def hit
    @participant.deal(@deck_cards, 1)
    @participant.check_for_bust? ? end_game_participant_bust : play_round
  end

  def dealers_turn
    if @dealer.check_for_bust?
      end_game_dealer_bust
    elsif @dealer.get_hand_total_value >= 16
      compare_hands
    else
      @dealer.deal(@deck_cards, 1)
      dealers_turn
    end
  end

  def participant_leading?
    @participant.get_hand_total_value > @dealer.get_hand_total_value
  end

  def compare_hands
    if participant_leading?
      @dealer.deal(@deck_cards, 1)
      dealers_turn
    else
      end_game_dealer_wins
    end
  end

  def end_game_participant_bust
    end_of_game
    Messages.participant_bust_message
  end

  def end_game_dealer_bust
    end_of_game
    Messages.dealer_bust_message
  end

  def end_game_dealer_wins
    end_of_game
    Messages.dealer_wins_message
  end

  def add_scores
    puts "Dealer total: #{@dealer.get_hand_total_value}"
    puts "Your total: #{@participant.get_hand_total_value}"
  end

  private

  def get_input
    gets.chomp.upcase
  end

  def end_of_game
    render_hands
    add_scores
  end
end
