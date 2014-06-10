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

def create_deck
  suits = ['C', 'D', 'H', 'S']
  card_values = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
  deck = {}
  suits.each do |suit|
    card_values.each_with_index do |v,i|
      if i == 0
        deck['A' + suit] = v
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
  return deck
end

def shuffle_deck(d)
  return d.keys.shuffle
end

def buy_chips
  puts "How many chips would you like to buy?"
  chips = gets.chomp.to_i
  return chips
end

def make_bet(chips)
  puts "Place your bet:"
  bet = gets.chomp.to_i
  if bet > chips
    puts "You don't have enough chips to play. Make a smaller bet:"
    bet = gets.chomp.to_i
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

def deal_cards(players_cards, dealers_cards, dealers_turn = false)
  puts "----Dealer's Cards----"
  
  if dealers_turn
    dealers_cards.each do |card|
      puts "  ------"
      puts "  | #{card} |"
      puts "  |    |"
      puts "  ------"
    end
    puts "Dealers total is: " + card_count(dealers_cards).to_s
  else
    puts "  ------"
    puts "  | #{dealers_cards[1]} |"
    puts "  |    |"
    puts "  ------"
    puts "  ------"
    puts "  |    |"
    puts "  |    |"
    puts "  ------"
  end

  puts "----Your Cards--------"

  players_cards.each do |card|
    puts "  ------"
    puts "  | #{card} |"
    puts "  |    |"
    puts "  ------"
  end

  puts "your total is: " + card_count(players_cards).to_s
end

def hit_or_stand
  puts "Would you like to 1) hit or 2) stand."
  action = gets.chomp.to_i
  return action
end
  

deck = create_deck
puts "Welcome to Las Vegas"
chip_count = buy_chips

# begin playing until game_over
begin
  shuffled_keys = shuffle_deck(deck)

  #deal initial cards
  players_cards = [shuffled_keys[0], shuffled_keys[2]]
  dealers_cards = [shuffled_keys[1], shuffled_keys[3]]

  bet = make_bet(chip_count)
  deal_cards(players_cards, dealers_cards)
  player_card_count = card_count(players_cards)
  dealer_card_count = card_count(dealers_cards)
  deck_index = 4
  while player_card_count < 21
    action = hit_or_stand
    if action == 1
      players_cards << shuffled_keys[deck_index]
      player_card_count = card_count(players_cards)
      deal_cards(players_cards, dealers_cards)
      deck_index += 1
    else
      break
    end
  end

  if player_card_count == 21
    puts "Congrats"
    if deck_index == 4
      puts "BlackJack!!!"
    end
    while dealer_card_count < 17
      dealers_cards << shuffled_keys[deck_index]
      dealer_card_count = card_count(dealers_cards)
      deck_index += 1
    end
    if dealer_card_count == 21
      deal_cards(players_cards, dealers_cards, true)
      puts "Dealer draws #{dealer_card_count}"
      puts "It's a Tie!"
      # chip count doesn't change
    elsif dealer_card_count > 21
      deal_cards(players_cards, dealers_cards, true)
      puts "Dealer busts! You Win"
      chip_count += 1.5 * bet
    else
      deal_cards(players_cards, dealers_cards, true)
      puts "You Win"
      chip_count += 1.5 * bet
    end
  elsif player_card_count > 21
    deal_cards(players_cards, dealers_cards, true)
    puts "Bust! Dealer shows cards"
    chip_count -= bet
  elsif player_card_count > dealer_card_count
    deal_cards(players_cards, dealers_cards, true)
    puts "You Win!"
    chip_count += bet
  else
    deal_cards(players_cards, dealers_cards, true)
    puts "You Lose! The House always wins! HaHaHa.."

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