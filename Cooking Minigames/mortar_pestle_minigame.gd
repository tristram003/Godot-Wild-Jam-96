extends Node3D
class_name MortarPestleMinigame
## this is a minigame where you crush shit into crumbles

var ingredient: IngredientResource

@onready var pestle_controller: CharacterBody3D = $PestleController
@onready var minigame_camera: Camera3D = $Camera3D
@onready var pestle_mesh: MeshInstance3D = $PestleMesh

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			minigame_end()

func _ready() -> void:
	minigame_camera.current = false
	pestle_controller.hide()
	pestle_mesh.show()

## This runs when the minigame starts and disables the player via the gamemaster script
func minigame_start():
	print("started")
	pestle_mesh.hide()
	pestle_controller.show()
	
	Gamemaster.minigame_started()
	minigame_camera.make_current()
	pestle_controller.toggle_active()

func minigame_end():
	print("ended")
	Gamemaster.minigame_ended()
	pestle_controller.toggle_active()
	_ready()

func _on_interactable_component_interacted() -> void:
	minigame_start()
