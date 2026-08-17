extends Node3D
class_name MortarPestleMinigame

@onready var pestle_controller: CharacterBody3D = $PestleController
@onready var minigame_camera: Camera3D = $Camera3D
@onready var pestle_mesh: MeshInstance3D = $PestleMesh

func _ready() -> void:
	minigame_camera.current = false

func minigame_start():
	print("started")
	show()
	pestle_mesh.hide()
	Gamemaster.minigame_started()
	minigame_camera.make_current()
	pestle_controller.toggle_active()
	get_parent().show()
	

func _on_interactable_component_interacted() -> void:
	minigame_start()
