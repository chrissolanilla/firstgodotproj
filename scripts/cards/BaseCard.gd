extends Node3D

class_name BaseCard

#i want to force my teammates to have to set this to something like water or fire
var element: String
var castTime: float
var rarity: String

func cardStart() -> void:
	#placeholder Start/activation method
	assert(false, "The method 'cardStart' must be overridden in the derived class")
	
#func cardTick() -> void:
	##placeholder tick 
	#assert(false, "The method 'cardTick' must be overridden in the derived class")

func cardEnd() -> void:
	#placeholder card end method
	assert(false, "The method 'cardEnd' must be overridden in the derived class")

func getRarity() -> String:
	return rarity

func getCastTime() -> float:
	return castTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
