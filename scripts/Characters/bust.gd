extends BaseCharacter

const MOUSE_SENSITIVITY = 0.002

var camera_rotation = Vector2.ZERO
var selected:int = 1

@onready var hotbar = $Hotbar
@onready var camera3D = $Camera3D
@onready var rayCast = $Camera3D/RayCast3D

# Preload the FireballCard scene (this should be a PackedScene)
var fireballCardScene = preload("res://Scenes/Cards/FireballCard.tscn")

var fireballCard

func _ready():
	# Lock mouse to screen
	SPEED = 5.0
	JUMP_VELOCITY = 4.5
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y = rotation.y - (event.relative.x * MOUSE_SENSITIVITY)
		#stop us from flying when looking up
		camera3D.rotation.x = camera3D.rotation.x - (event.relative.y * MOUSE_SENSITIVITY)
		#stop us from looking 360 up
		camera3D.rotation.x = clamp(camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90) ) 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump and trigger Fireball card
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		#velocity.x = 0 also works but godot insisted on this
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	#handle mouse clicks
	if Input.is_action_just_pressed("left_click"):
		#activate the card selected in hotbar
		# Instantiate and add the fireball card only when space (jump) is pressed
		if fireballCardScene:
			fireballCard = fireballCardScene.instantiate()
			add_child(fireballCard)  # Now it will only be added when you press space
			fireballCard.cardStart()

	#handle the right click? idk what to put in here, maybe a block or some weird attack
	#if Input.is_action_just_pressed("right_click"):
		#some weird code or action
	#handle hotbar stuff
	if Input.is_action_just_pressed("1"):
		selected = 0
		hotbar.select(selected)

	if Input.is_action_just_pressed("2"):
		selected = 1
		hotbar.select(selected)

	if Input.is_action_just_pressed("3"):
		selected = 2
		hotbar.select(selected)

	if Input.is_action_just_pressed("4"):
			selected = 3
			hotbar.select(selected)

	if Input.is_action_just_pressed("5"):
			selected = 4
			hotbar.select(selected)

	if Input.is_action_just_pressed("6"):
			selected = 5
			hotbar.select(selected)

	if Input.is_action_just_pressed("7"):
			selected = 6
			hotbar.select(selected)

	move_and_slide()
