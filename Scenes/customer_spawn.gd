extends Node3D 

# Spawn count determines how many mushrooms spawn at timers end
@export var spawn_count: int = 1
@export var object_to_spawn: PackedScene

@onready var timer: Timer = $Timer
@onready var marker: Marker3D = $SpawnArea/Marker3D
#@onready var object: RigidBody3D = $skeleton_customer
# @onready var object: CharacterBody3D = $skeleton_customer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	print("Timer has elasped")
	spawn_object()

func spawn_object() -> void:
	if object_to_spawn == null:
		return
		
	var spawn_position = marker.global_position 
	var object = object_to_spawn.instantiate()
	get_tree().current_scene.add_child(object)
	object.global_position = spawn_position

	# Duplicates object in scene at marker location
	#var object_spawn = object.duplicate()
	#get_tree().current_scene.add_child(object_spawn)
	#object_spawn.global_position = spawn_position
	#object.visible(true)

		## leftover but keep around just in case
	#var object_spawn = object.instance()
	#get_tree().current_scene.add_child(object_spawn)
	#object_spawn.global_position = spawn_position
