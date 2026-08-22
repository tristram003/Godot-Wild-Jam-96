extends Node3D
class_name ObjectSpawner

# Spawn count determines how many mushrooms spawn at timers end
@export var spawn_count: int = 3
@export var object_to_spawn: PackedScene
@export var timer_length: float = 20.0

@onready var spawn_area: Area3D = $SpawnArea
@onready var collision_shape: CollisionShape3D = $SpawnArea/CollisionShape3D
@onready var timer: Timer = $Timer
@onready var marker: Marker3D = $SpawnArea/Marker3D


func _ready() -> void:
	timer.start(timer_length)
	timer.timeout.connect(spawn_object)


func spawn_object() -> void:
	if object_to_spawn == null:
		return

	for num in spawn_count:
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
				0.15,
				random_z
			)

			var object = object_to_spawn.instantiate()
			get_tree().current_scene.add_child(object)
			object.global_position = spawn_position


		### LEFTOVER CODE, LEAVE FOR REFERENCE
		# Duplicates object in scene into random locations
		#var object_spawn = object.duplicate()
		#get_tree().current_scene.add_child(object_spawn)
		#object_spawn.global_position = spawn_position
	
	#var spawn_position = marker.global_position 
