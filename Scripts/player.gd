extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 6

var sensivity = 0.003 
var onCooldown = false
var gold = 15
var hp = 50
var toggle_on = false
var held_target = null

@onready var goldLabel = $HUD/GoldLabel
@onready var camera = $Camera3D
@onready var animationPlayer = $AnimationPlayer
@onready var cooldown = $AttackCooldown
@onready var see_cast = $Camera3D/SeeCast
@onready var hand = $Camera3D/SpringArm3D/ItemHolder

func player():
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensivity)
		camera.rotate_x(-event.relative.y * sensivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

#func interact():
	#if Input.is_action_just_pressed("interact"):
		#print("Hello!")

func update_HUD():
	goldLabel.text = str(gold)

func _process(_delta):
	update_HUD()
	
	# Quits out the game
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

	# Handles ojbect interaction 
	if Input.is_action_just_pressed("pickup"):
		if held_target:
			held_target.freeze = false
			held_target = null
		elif see_cast.is_colliding():
			var target = see_cast.get_collider()
			if target.is_in_group("pickable"):
				held_target = target
				held_target.freeze = true

	if held_target:
		held_target.global_position = hand.global_position
		held_target.global_rotation = hand.global_rotation
	
	# Handles UI
	$CanvasLayer/BoxContainer/Interact.hide()
	if see_cast.is_colliding() and held_target == null:
		var target = see_cast.get_collider()
		if target.has_method("interact"):
			$CanvasLayer/BoxContainer/Interact.show()

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
