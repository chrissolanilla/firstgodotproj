extends BaseCard

var FireBallProjectile = preload("res://Scenes/Fireball.tscn")
var remainingCastTime: float
func _ready() -> void:
	element = "Fire"
	castTime = 2.0
	rarity = "Common"
	remainingCastTime= castTime
	
func cardStart() -> void:
	print("Fireball card activated")

#func cardTick() -> void:
	#print("Fireball card is ticking")

func _process(delta: float) -> void:
	if remainingCastTime > 0:
		remainingCastTime -= delta
	else:
		cardEnd()
func cardEnd() -> void:
	print("Fireball card ended")
	spawnFireball()
	#shoot a projectile where the user is looking
	#spawn fireball projectile that inherrits from projectile. 

func spawnFireball() -> void: 
	var fireball = FireBallProjectile.instantiate()  # Instantiate the fireball projectile
	var camera = get_parent().get_node("Camera_Controller/Camera_Target/Camera3D")
	if camera == null:
		print("Camera not found")
	else: 
		print("camera found")
	var direction = -camera.global_transform.basis.z.normalized()  # Get the forward direction of the camera

	# First, add the fireball to the scene
	get_parent().add_child(fireball)

	# Set the fireball's position slightly in front of the player
	fireball.position = global_position + direction * 2.0  # Use position instead of transform

	# Align the fireball to face the correct direction
	fireball.look_at(fireball.position + direction)

	# Set the fireball speed or any other properties
	fireball.speed = 10.0
	get_parent().add_child(fireball)
