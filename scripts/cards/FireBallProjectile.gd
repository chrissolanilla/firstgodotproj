extends BaseProjectile

func _ready() -> void:
	# Ensure that the Area3D node exists and connect to its collision signal
	var area = $HitArea3D
	if area == null:
		print("Area3D not found!")
	else:
		area.connect("area_entered", Callable(self, "_on_hit"))

## Handle body collisions
#func _on_hit_area_3d_body_entered(body):
	#if body.is_in_group("Chris"):
		#print("WE HIT SOMETHING")
		#body.queue_free()
		#queue_free()
		#hit()
