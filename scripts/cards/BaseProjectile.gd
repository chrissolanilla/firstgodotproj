class_name BaseProjectile extends RigidBody3D

var lifeTime: float = 5.0
var speed: float = 30.0
var hasDropOff: bool  # Whether gravity affects the projectile
var gravity: float = -9.8 
var direction: Vector3 = Vector3.ZERO  # Store direction of projectile
var friendlyFire: bool = false

func hit() -> void:
	print("Projectile hit!")
	queue_free()  # Destroy the projectile on hit

func _ready() -> void:
	if direction == Vector3.ZERO:
		direction = -global_transform.basis.z  # Default forward if not set
	
	# Connect the signal using a Callable with the correct signature
	$HitArea3D.connect("body_entered", Callable(self, "_on_hit_body"))

func _process(delta: float) -> void:
	lifeTime -= delta
	if lifeTime <= 0:
		print("We didnt hit anything")
		queue_free()  
	# Move the projectile forward
	move_and_collide(-transform.basis.z * delta * speed)

	if hasDropOff:
		translate(Vector3(0, gravity * delta, 0))

# Handle body collisions
func _on_hit_area_3d_body_entered(body):
	if body.is_in_group("Chris"):
		print("WE HIT SOMETHING")
		body.queue_free()
		queue_free()
		hit()
		
		
