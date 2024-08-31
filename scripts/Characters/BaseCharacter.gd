extends CharacterBody3D
class_name BaseCharacter

var SPEED:float
var JUMP_VELOCITY:float
#each character should have a deck of cards
var deck_of_cards = []
#each character should 
var hand = []

#common methods shared by all characters
func _ready() -> void:
	#they should all have a deck of cards i guess
	deck_of_cards = ["Fireball", "Shield", "Heal", "Fireball", "Fireball", "Fireball", "Fireball", "Fireball"]
	#at the start of each game, each character will draw 5 cards
	draw_card(5)
	pass

func take_damage(amount) -> void:
	#logic for taking damage
	pass

func draw_card(amount:int) -> void:
	#logic for drawing a card from the deck
	for i in range(amount):
		if hand.size() < 7:
			var card = deck_of_cards.pop() #our deck is a stack
			hand.append(card)
		else:
			#discard if we have more than 7 cards in our hand
			hand.pop_front()
			var card = deck_of_cards.pop_back()
			hand.append(card)
		print("Hand after drawing is: %s" % hand)
	pass

func play_card(card):
	if card in hand:
		hand.erase(card)
		#do the card's effect somehow
		print("Played card: %s" % card)
	else:
		print("Card not in hand: %s" % card)
		
func discard_card(card):
	if card in hand:
		# we could also add it to the graveyard potentially
		hand.erase(card)
		print("discarded card: %s" % card)
