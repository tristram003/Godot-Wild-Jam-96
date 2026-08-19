extends Node3D 

# Spawn count determines how many mushrooms spawn at timers end
@export var spawn_count: int = 3

@onready var spawn_area: Area3D = $SpawnArea
@onready var collision_shape: CollisionShape3D = $SpawnArea/CollisionShape3D
@onready var timer: Timer = $Timer

# Mushroom is different objects changed in out scene
# Might be a better way to architect that
@onready var object = $Mushroom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_timer_timeout() -> void:
	print("Timer has elasped")
	for i in spawn_count:
		spawn_object()

func spawn_object() -> void:
	var shape = collision_shape.shape
	if shape is SphereShape3D:
		# Use raduis instead of shape for sphere geometry
		var radius = shape.radius
		var angle = randf_range(0.0, TAU)
		var distance = sqrt(randf()) * radius
		var random_x = cos(angle) * distance
		var random_z = sin(angle) * distance
		var spawn_position = collision_shape.global_position + Vector3(
			random_x,
			0.5,
			random_z
		)

		# Duplicates object in scene into random locations
		var object_spawn = object.duplicate()
		get_tree().current_scene.add_child(object_spawn)
		object_spawn.global_position = spawn_position

		## leftover but keep around just in case
		#var object_spawn = object_scene.instantiate()
		#get_tree().current_scene.add_child(object_spawn)
		#object_spawn.global_position = spawn_position
