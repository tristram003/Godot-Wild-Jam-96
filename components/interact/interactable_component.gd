extends Area3D
class_name Interactable

signal interacted

@export var display_text: String

func interact() -> void:
	interacted.emit()
