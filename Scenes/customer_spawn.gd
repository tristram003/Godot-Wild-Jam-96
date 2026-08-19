extends Node3D 

### KNOWN ISSUES
	# Customer continually spawns and duplicates himself
	# Need to hide initial copy somehow 


# Spawn count determines how many mushrooms spawn at timers end
@export var spawn_count: int = 1

@onready var timer: Timer = $Timer
@onready var marker: Marker3D = $SpawnArea/Marker3D
@onready var object = $skeleton_customer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#object.visible(false)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_timer_timeout() -> void:
	print("Timer has elasped")
	for i in spawn_count:
		spawn_object()

func spawn_object() -> void:
	var spawn_position = marker.global_position 
	# Duplicates object in scene at marker location
	var object_spawn = object.duplicate()
	get_tree().current_scene.add_child(object_spawn)
	object_spawn.global_position = spawn_position
	#object.visible(true)

		## leftover but keep around just in case
		#var object_spawn = object_scene.instantiate()
		#get_tree().current_scene.add_child(object_spawn)
		#object_spawn.global_position = spawn_position
