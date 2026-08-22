extends RigidBody3D
class_name Ingredient

var display_text: String = "Click to pickup "
@export var item_mesh: MeshInstance3D
@export var ingredient_data: IngredientResource:
	set(item):
		if item:
			ingredient_data = item
			display_text += ingredient_data.name

@onready var interactable: Interactable = $Interactable
@onready var mesh: MeshInstance3D = $MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
