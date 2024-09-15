extends Control

class_name BaseCard

#i want to force my teammates to have to set this to something like water or fire
var cardName:String
var element: String
var castTime: float
var rarity: String

#constructor in godot?
func init(cname:String, ele:String, ct:float, rarty:String) -> void:
	cardName = cname
	element = ele
	castTime = ct
	rarity = rarty

func cardStart() -> void:
	#placeholder Start/activation method
	assert(false, "The method 'cardStart' must be overridden in the derived class")

func cardEnd() -> void:
	#placeholder card end method
	assert(false, "The method 'cardEnd' must be overridden in the derived class")

func getRarity() -> String:
	return rarity

func getCastTime() -> float:
	return castTime

func setName() -> void :
	cardName = get_name()

func getName() -> String :
	return cardName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if cardName == "":
		setName()

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
