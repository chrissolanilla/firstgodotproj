extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.1

var camera_rotation = Vector2.ZERO

func _ready():
	#lock mouse to screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	# Capture the mouse movement to rotate the camera
	if event is InputEventMouseMotion:
		#rotate the camera and the player when the move the mouse left to right
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY
		camera_rotation.y -= event.relative.y * MOUSE_SENSITIVITY
		camera_rotation.y = clamp(camera_rotation.y, -90, 90)
		# rotate the camera up and down but not the players roation
		$Camera_Controller.rotation_degrees.x = camera_rotation.y
		# keep camera in sync with the player on the side to side
		$Camera_Controller.rotation_degrees.y = rotation_degrees.y


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	#add smooth camera, lower number is slower speed. 
	#must have this after position calculations
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.1)
