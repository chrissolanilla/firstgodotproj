extends TextureButton
var exportedDeck = DeckManager.get_deck()

func _on_pressed() -> void:
	#get our card and add it to our deck
	var base_card = get_parent() as BaseCard
	
	if exportedDeck != null:
		DeckManager.add_card_to_deck(base_card)
		print("card added: ", base_card.getName())
	DeckManager.show_deck()
