# coding: utf-8

# san' procedural blackjack game

# spade, hearts, club(plum blossom), diamonds

# calculate score
def calculate(cards)
  sum = 0
  cards.each do |card|
    if card[1] == 'A'
      socre = 11
    else
      score = card[1].to_i
      if score == 0
        # J, Q, K
        score = 10
      end
    end
    sum += score
  end

  cards.select { | card | card[1] == 'A' }.size.times do
    if sum > 21
      sum -= 10
    end
  end

  sum
end

# initial deck
deck = []
suits = %w(S H C D)
cards = %w(2 3 4 5 6 7 8 9 10 J Q K A)
suits.each do |suit|
  cards.each do |card|
    deck << [suit, card]
  end
end
deck.shuffle!

# dealing two cards
my_cards = []
dealer_cards = []

my_cards << deck.pop
dealer_cards << deck.pop
my_cards << deck.pop
dealer_cards << deck.pop

puts "dealer cards: #{ dealer_cards }, score is #{ calculate(dealer_cards) }"
puts "my cards: #{ my_cards }, score is #{ calculate(my_cards) }"

# player turn
my_cards_score = calculate(my_cards)
while my_cards_score < 21
  # ask whether need a card
  puts "Do you want a card? 1) yes 2) no"
  choose = gets.chomp

  if choose == '2'
    break
  else
    my_cards << deck.pop
    my_cards_score = calculate(my_cards)

    puts "your cards is #{ my_cards }, and score is #{ my_cards_score }"
  end
end

if my_cards_score == 21
  puts "you win! you hit blackjack!"
  exit
elsif my_cards_score > 21
  puts "sorry, you busted."
  exit
end

# dealer turn
dealer_cards_score = calculate(dealer_cards)
while dealer_cards_score < 17
  dealer_cards << deck.pop
  dealer_cards_score = calculate(dealer_cards)
  puts "dealer cards: #{ dealer_cards }, score is #{ dealer_cards_score }"
  if dealer_cards_score == 21
    puts "sorry, dealer hit blackjack, dealer win."
    exit
  elsif dealer_cards_score > 21
    puts "dealer busted, congratinations, you win!"
    extt
  end
end

# check result
if my_cards_score > dealer_cards_score
  puts "you win! your score is greater!"
elsif my_cards_score < dealer_cards_score
  puts "sorry, dealer win."
else
  puts "it's a tie."
end