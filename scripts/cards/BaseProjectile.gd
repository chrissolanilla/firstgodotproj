extends Node3D

class_name BaseProjectile

var lifeTime: float
var speed: float
var hasDropOff: bool  # Whether gravity affects the projectile
var gravity: float = -9.8 
var direction: Vector3 = Vector3.ZERO #store direction of projectile
var friendlyFire: bool = false

func hit() -> void:
	assert(false, "The method BaseProjectile.hit() must be overriden")
	
func _ready() -> void:
	# Direction should already be set before _ready() is called
	if direction == Vector3.ZERO:
		direction = -global_transform.basis.z  # Default forward if not set
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifeTime -= delta
	if lifeTime <= 0:
		queue_free() #destroy function\
	#moves projectile forwrad
	global_position += direction * speed * delta
	if hasDropOff:
		translate(Vector3(0, gravity * delta, 0))
