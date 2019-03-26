require_relative './messages'
require_relative './deck'
require_relative './player'

class Game
  def initialize()
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
    command = gets.chomp
    valid = false

    while(!valid)
      if command == 'Y' or command == 'N'
        valid = true
      else
        Messages.wrong_play_input
        command = gets.chomp
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
    puts "Do you want to HIT (H) or STAY (S)?"
    command = gets.chomp
    valid = false

    while(!valid)
      if command == "H" or command == "S"
        valid = true
      else
       puts "Wrong Input, Please press H or S then ENTER"
        command = gets.chomp
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
    @participant.check_for_bust ? end_game_participant_bust : play_round
  end

  def dealers_turn
    if @dealer.check_for_bust
      end_game_dealer_bust
    elsif @dealer.get_hand_total_value >= 16
      compare_hands
    else
      @dealer.deal(@deck_cards, 1)
      dealers_turn
    end
  end

  def compare_hands
    if @participant.get_hand_total_value > @dealer.get_hand_total_value
      @dealer.deal(@deck_cards, 1)
      dealers_turn
    else
      end_game_dealer_wins
    end
  end

  def end_game_participant_bust
    render_hands
    add_scores
    Messages.participant_bust_message
  end

  def end_game_dealer_bust
    render_hands
    add_scores
    Messages.dealer_bust_message
  end

  def end_game_dealer_wins
    render_hands
    add_scores
    Messages.dealer_wins_message
  end

  def add_scores
    puts "Dealer total: #{@dealer.get_hand_total_value}"
    puts "Your total: #{@participant.get_hand_total_value}"
  end
end
