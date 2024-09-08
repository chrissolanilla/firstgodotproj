extends Area3D

func _on_body_entered(body: Node3D) -> void:
	#add the card to the player
	print(body)
	if body.name == "Bust":
		print("its bust")
		print(body.hotbar)
		add_card_to_hand(body, "res://assets/cardback.jpg", "poop")
	queue_free()
	
func add_card_to_hand(body: Node3D, cardIcon:String, cardName:String):
	body.hand.append(cardName)
	body.update_hotbar(cardIcon)
