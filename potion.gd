extends RigidBody3D
class_name Potion

@export var potion_name: String
@export var potion_color: Color

var display_text: String = "Click to Pickup %s" % potion_name + "\n E to Drink"

@onready var mesh: MeshInstance3D = $Mesh
@onready var interactable: Interactable = $Interactable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.display_text = display_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func drink():
	pass
