extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 6

var sensivity =0.003 
var onCooldown = false
var gold = 15
var hp = 50
var maxHp = 50

@onready var goldLabel = $HUD/GoldLabel
@onready var hpBar= $HUD/HPbar
@onready var camera = $Camera3D
@onready var animationPlayer = $AnimationPlayer
@onready var cooldown = $AttackCooldown
@onready var see_cast: RayCast3D = $Camera3D/SeeCast


func player():
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensivity)
		camera.rotate_x(-event.relative.y * sensivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))
	

func _ready():
	hpBar.max_value = 50
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func attack():
	if Input.is_action_just_pressed("Attack") and onCooldown == false:
		animationPlayer.play("Sword Swing")
		onCooldown = true
		cooldown.start()


func update_HUD():
	hpBar.value = hp
	goldLabel.text = str(gold)


func _process(_delta):
	update_HUD()
	attack()
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	

func _physics_process(delta: float) -> void:
	
	if see_cast.is_colliding():
		var target = see_cast.get_collider()
		print(target)
	
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


func _on_attack_cooldown_timeout():
	onCooldown = false
	pass # Replace with function body.
