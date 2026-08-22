extends CharacterBody3D

@export_multiline var display_text: String = "TESTING"
@onready var BuyArea: Area3D = $BuyArea
var wanteditem: Potion 

# PSEUDOCODE
#	on interact
#		trigger dialogue
#		if potion in area3D
#			delete potion 
#			score ticks up 

func _input(event: InputEvent) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

 
func interact():
	print("interact has triggered")
	check_for_potion()
	
func check_for_potion():
	if BuyArea.has_overlapping_bodies():
		var overlaps = BuyArea.get_overlapping_bodies()
		for body in overlaps:
			if body.is_in_group('potions'):
				print(body.name)
				body.queue_free()
				Gamemaster.gold =+ 10
				print(Gamemaster.gold)
				Gamemaster.update_gold.emit()
				#Gamemaster.score =+ 10
				#print(Gamemaster.score)
		print("object detected")
