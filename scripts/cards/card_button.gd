extends Button

var card_reference: BaseCard
@onready var label: Label = $Label
@onready var sprite = $CardFront


func set_card(card: BaseCard):
	card_reference = card



func _on_pressed() -> void:
	print("we clicked button")
