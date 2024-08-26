extends BaseProjectile

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle fireball movement or other per-frame logic
	pass

func _ready() -> void:
	# Ensure that the Area3D node exists and connect to its collision signal
	var area = $Area3D
	if area == null:
		print("Area3D not found!")
	else:
		area.connect("area_entered", Callable(self, "_on_hit"))

	# Override hit method for fireball-specific behavior
func hit() -> void:
	print("Fireball hit!")
	queue_free()  # Remove fireball on hit

func _on_hit(area):
	print("Hit detected!")
	hit()
