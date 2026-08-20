extends RigidBody3D
class_name Item


@export var display_text: String = "Click to pickup "
@export var item_mesh: MeshInstance3D
@export var ingredient_data: IngredientResource:
	set(item):
		if item:
			ingredient_data = item
			display_text += ingredient_data.name


func interact():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
