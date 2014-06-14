require 'pry'
# psuedo code
# create deck and shuffle it
# dealer welcome and buy chips
# max and min bets
# make bet
# deal cards
# only show players cards and one of dealers cards
# players turn - ask to hit or stand
# check for blackjack - pays 3 to 2
#   dealers turn
#
# if hit
#   if bust
#     lose
#   elsif 21
#     dealers turn
#   else
#     ask to hit or stand again
# elsif stand
#   dealers turn
#
# dealers turn
# while less than 17
#   hit
# end
# if bust
#   player wins
#   pay chips
# else
#   compare players and dealers cards
#   exchange chips accordingly - tie 1:1 - otherwise 2:1

class BlackJack
  attr_accessor :deck, :dealers_cards, :players_cards, :chip_count
  
  def initialize
    @deck = {}
    @dealers_cards = []
    @players_cards = []
    @chip_count = 0
  end

  def create_deck
    suits = ['C', 'D', 'H', 'S']
    card_values = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
    suits.each do |suit|
      card_values.each_with_index do |v,i|
        if i == 0
          deck['A' + suit] = v
        elsif i == 9
          deck['T' + suit] = v
        elsif i == 10
          deck['J' + suit] = v
        elsif i == 11
          deck['Q' + suit] = v
        elsif i == 12
          deck['K' + suit] = v
        else
          deck[v.to_s + suit] = v
        end
      end
    end
    self.deck = deck
  end

  def shuffle_deck
    return self.deck.keys.shuffle
  end

  def buy_chips
    puts "How many chips would you like to buy?"
    chips = gets.chomp.to_f
    self.chip_count = chips
  end

  def make_bet
    puts "Place your bet:"
    bet = gets.chomp.to_f
    until bet >= self.chip_count
      puts "You don't have enough chips to play. Make a smaller bet:"
      bet = gets.chomp.to_f
    end
    return bet
  end


  def card_count(cards)
    deck = create_deck
    v = 0
    cards.each do |k|
      v += deck[k]
    end
    if v > 21
      v = 0
      cards.each do |k|
        if k[0] == 'A'
          v += 1
        else
          v += deck[k]
        end
      end
    end 
    return v
  end

  def deal_cards(dealers_turn = true)
    puts "----Dealer's Cards----"

    if dealers_turn
      self.dealers_cards.each do |card|
        puts "  ------"
        puts "  | #{card} |"
        puts "  |    |"
        puts "  ------"
      end
      puts "Dealers total is: " + card_count(self.dealers_cards).to_s
    else
      puts "  ------"
      puts "  | #{self.dealers_cards[1]} |"
      puts "  |    |"
      puts "  ------"
      puts "  ------"
      puts "  |    |"
      puts "  |    |"
      puts "  ------"
    end

    puts "----Your Cards--------"

    self.players_cards.each do |card|
      puts "  ------"
      puts "  | #{card} |"
      puts "  |    |"
      puts "  ------"
    end

    puts "your total is: " + card_count(self.players_cards).to_s
  end

  def hit_or_stand
    puts "Would you like to 1) hit or 2) stand."
    action = gets.chomp.to_i
    return action
  end

  def play
    self.create_deck
    puts "Welcome to Las Vegas"
    self.buy_chips

    # begin playing until game_over
    begin
      shuffled_keys = shuffle_deck

      #deal initial cards
      self.players_cards = [shuffled_keys[0], shuffled_keys[2]]
      self.dealers_cards = [shuffled_keys[1], shuffled_keys[3]]

      bet = make_bet(chip_count).to_f
      deal_cards(self.players_cards, self.dealers_cards, false)
      player_card_count = card_count(self.players_cards)
      dealer_card_count = card_count(self.dealers_cards)
      deck_index = 4


      blackjack = false
      # check for blackjack
      if player_card_count == 21
        puts "BlackJack!!!"
        blackjack = true
      else
        #players turn
        while player_card_count < 21
          action = self.hit_or_stand
          if action == 1
            players_cards << shuffled_keys[deck_index]
            self.player_card_count = card_count(self.players_cards)
            deal_cards(false)
            deck_index += 1
          else
            break
          end
        end
      end

      if player_card_count > 21
        deal_cards(self.players_cards, self.dealers_cards)
        puts "Bust! Dealer Shows cards."
        chip_count -= bet
      else
        # dealers turn
        while dealer_card_count < 17
          self.dealers_cards << shuffled_keys[deck_index]
          self.dealer_card_count = card_count(self.dealers_cards)
          deck_index += 1
        end
        self.deal_cards(self.players_cards, self.dealers_cards)
        if self.dealer_card_count > 21
          puts "Dealer draws #{self.dealer_card_count}"
          puts "Dealer busts! You Win"
          chip_count += ( blackjack ) ? 1.5 * bet : bet
        elsif player_card_count == dealer_card_count
          puts "Dealer draws #{self.dealer_card_count}"
          puts "It's a Tie!"
          # chip count doesn't change
        elsif player_card_count > dealer_card_count
          puts "Dealer draws #{dealer_card_count}"
          puts "You Win!"
          chip_count += ( blackjack ) ? 1.5 * bet : bet
        elsif player_card_count < dealer_card_count
          puts "Dealer draws #{dealer_card_count}"
          puts "You Lose! The House always wins! HaHaHa.."
          chip_count -= bet
        end
      end


      puts "Chip count: #{chip_count}"
      if chip_count == 0
        puts "You have no chips left. Come Again"
      else
        puts "Hand Over. Play Again? (y or n)"
        y_n = gets.chomp
        game_over = ( y_n == 'n' ) ? true : false
      end
    end until game_over || chip_count == 0
  
  end

end

game = BlackJack.new