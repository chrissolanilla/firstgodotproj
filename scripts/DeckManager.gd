extends Node

var player_deck: Array = []

func set_deck(deck:Array):
	player_deck = deck

func get_deck() -> Array:
	return player_deck

#now we add ui functions to start the game and to add cards to the deck

func add_card_to_deck(card: BaseCard) -> void:
	player_deck.append(card.getName())
	print("added card to deck: ", card.getName())
	
func show_deck() -> void:
	print("Current Deck: ", player_deck)
