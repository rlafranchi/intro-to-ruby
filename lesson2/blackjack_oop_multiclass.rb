require 'pry'
# BlackJack OOP

class Deck
  attr_accessor :cards, :index
  
  def initialize
    @cards = {}
    suits = ['C', 'D', 'H', 'S']
    card_values = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
    suits.each do |suit|
      card_values.each_with_index do |v,i|
        if i == 0
          cards['A' + suit] = v
        elsif i == 9
          cards['T' + suit] = v
        elsif i == 10
          cards['J' + suit] = v
        elsif i == 11
          cards['Q' + suit] = v
        elsif i == 12
          cards['K' + suit] = v
        else
          cards[v.to_s + suit] = v
        end
      end
    end
    @index = 0
  end
  
  def deal_one(sh_cards)
    deal_one = sh_cards[index]
    self.index += 1
    deal_one
  end
  
  def shuffle_cards
    cards.keys.shuffle
  end
    
end

module Hand
  def show_blank
      puts "  ------"
      puts "  |    |"
      puts "  |    |"
      puts "  ------"
  end
  
  def show_hand
    show_name
    cards.each do |card|
      puts "  ------"
      puts "  | #{card} |"
      puts "  |    |"
      puts "  ------"
    end
  end
  
  def show_name
    puts "----#{name}"
  end
  
  def show_total
    puts "-----Total: #{card_count}"
  end
  
  def card_count
    deck = Deck.new.cards
    card_count = 0
    cards.each do |k|
      card_count += deck[k]
    end
    if card_count > 21
      card_count = 0
      cards.each do |k|
        if k[0] == 'A'
          card_count += 1
        else
          card_count += deck[k]
        end
      end
    end 
    card_count
  end
  
  def add_card(new_card)
    cards << new_card
  end
end

class Player
  include Hand
  
  attr_accessor :name, :cards
  
  def initialize(n)
    @name = n
    @cards = []
  end
end

class Dealer
  include Hand
  
  attr_accessor :name, :cards
  
  def initialize
    @name = "Dealer"
    @cards = []
  end
end

class BlackJack
  attr_accessor :player, :dealer, :cards, :deck, :chip_count, :game_over, :bet
  
  def initialize(n)
    @player = Player.new(n)
    @dealer = Dealer.new
    @deck = Deck.new
    @cards = []
    @game_over = false
    @bet = 0
  end
  
  def buy_chips
    puts "Welcome to Las Vegas"
    puts "How many chips would you like to buy?"
    self.chip_count = gets.chomp.to_f
  end
  
  def deal_cards
    self.cards = deck.shuffle_cards
    player.add_card(deck.deal_one(cards))
    dealer.add_card(deck.deal_one(cards)) 
    player.add_card(deck.deal_one(cards))

    dealer.show_hand
    dealer.show_blank
    
    player.show_hand
    player.show_total

    dealer.add_card(deck.deal_one(cards))
  end

  def make_bet
    puts "Place your bet:"
    self.bet = gets.chomp.to_f
    until bet <= chip_count
      puts "You only have #{chip_count} chips. Make a smaller bet:"
      self.bet = gets.chomp.to_f
    end
    bet
  end

  def hit_or_stand?
    puts "Would you like to 1) hit or 2) stand."
    action = gets.chomp.to_i
    until action == 1 || action == 2
      puts "Pleas enter 1 to hit or 2 to stand."
      action = gets.chomp.to_i
    end
    action = ( action == 1 ) ? true : false
  end

  def game_over?
    puts "Chip count: #{chip_count}"
    if chip_count == 0
      puts "You have no chips left. Come Again"
      game_over = false
    else
      puts "Hand Over. Play Again? (y or n)"
      y_n = gets.chomp
      game_over = ( y_n == 'n' ) ? true : false
    end
    game_over
  end

  def play
    buy_chips

    # begin playing until game_over
    begin
      # reset everything for multiple hands
      self.cards = []
      player.cards = []
      dealer.cards = []
      deck.index = 0
      
      make_bet
      deal_cards

      blackjack = false
      # check for blackjack
      if player.card_count == 21
        puts "BlackJack!!!"
        blackjack = true
      else
        #players turn
        while player.card_count < 21
          if hit_or_stand?
            player.add_card(deck.deal_one(cards))
            player.show_hand
            player.show_total
          else
            break
          end
        end
      end
      
      if player.card_count > 21
        dealer.show_hand
        dealer.show_total
        puts "Bust! Dealer Shows cards."
        self.chip_count -= bet
      else
        # dealers turn
        while dealer.card_count < 17
          dealer.add_card(deck.deal_one(cards))
        end
        dealer.show_hand
        dealer.show_total
        
        player.show_hand
        player.show_total
        
        if dealer.card_count > 21
          puts "Dealer busts! You Win"
          self.chip_count += ( blackjack ) ? 1.5 * bet : bet
        elsif player.card_count == dealer.card_count
          puts "It's a Tie!"
          # chip count doesn't change
        elsif player.card_count > dealer.card_count
          puts "You Win!"
          self.chip_count += ( blackjack ) ? 1.5 * bet : bet
        elsif player.card_count < dealer.card_count
          puts "You Lose! The House always wins! HaHaHa.."
          self.chip_count -= bet
        end
      end
      
    end until game_over? || chip_count == 0
  
  end
end

game = BlackJack.new("Bob")
game.play