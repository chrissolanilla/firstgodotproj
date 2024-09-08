extends BaseCharacter

const MOUSE_SENSITIVITY = 0.002
const MAX_HOTBAR_SLOTS = 7
var empty_icon = load("res://icon.svg")

#var selected:int = 1 base class has this variable already

@onready var hotbar = $Hotbar
@onready var camera3D = $Camera3D
@onready var rayCast = $Camera3D/RayCast3D

# Preload the FireballCard scene (this should be a PackedScene)
var fireballCardScene = preload("res://Scenes/Cards/FireballCard.tscn")

var fireballCard

func initialize_hotbar() -> void:
	hotbar.clear()
	for i in range(MAX_HOTBAR_SLOTS):
		hotbar.add_item("") #adds empty item
		hotbar.set_item_icon(i, empty_icon)

func _ready():
	super._ready()
	# Lock mouse to screen
	SPEED = 5.0
	JUMP_VELOCITY = 4.5
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	initialize_hotbar()#cause im lazy
	draw_card(5)
	drawCardTimer.start()

func update_hotbar(iconPath: String) -> void:
	for i in range(MAX_HOTBAR_SLOTS):
		var slot_number_text = str(i+1) #makes thign numeberd 1-7
		if i< hand.size():
			#add an icon to the hotbar
			#ideally we should load in the correct icon for what the card is named
			#we should also set each slot its own icon, not all the slots the same icon
			hotbar.set_item_icon(i, load(iconPath))
			hotbar.set_item_text(i,slot_number_text)
		else:
			hotbar.set_item_icon(i,empty_icon)
		
			

func draw_card(amount:int)-> void:
	for i in range(amount):
		if hand.size() < 7:
			var card = deck_of_cards.pop_back()
			hand.append(card)
			update_hotbar("res://assets/fireball52x63.png") #update the hotbar with our card
		else:
			#discard if we have mroe than 7 cards
			hand.pop_front()
			var card = deck_of_cards.pop_back()
			hand.append(card)
			update_hotbar("res://assets/fireball52x63.png")
		#print("Hand after darawing is: %s" % hand)
		
#this really hurts to override but we kind of need to so we can update the hotbar
func play_card(card):
	if card in hand:
		hand.erase(card)
		update_hotbar("res://assets/fireball52x63.png")
		print("played card: %s" % card)
		#actually play the card
		#this is not good idea, we are not having a shit ton of if statements.
		#cards should be objects and have a card.play() method
		if card == "Fireball":
			cast_fireball()
	else: 
		print("Card not in hand: %s" % card)

func cast_fireball():
	if fireballCardScene:
		fireballCard = fireballCardScene.instantiate()
		add_child(fireballCard)
		fireballCard.cardStart()

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
		# Use the selected card in the hotbar
		if selected < hand.size():
			play_card(hand[selected])

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
