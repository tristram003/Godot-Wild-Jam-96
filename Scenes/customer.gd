extends CharacterBody3D

@export_multiline var display_text: String = "TESTING"
@onready var BuyArea: Area3D = $BuyArea
@onready var potion = $PotionTesting

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
func interact():
	print("interact has triggered")
	check_for_potion()
	
func check_for_potion():
	if potion in BuyArea.get_overlapping_bodies():
		print("potion in area")
	else:
		print("potion NOT IN AREA")


#if body.has_method("get_item_type"):
	#var item_type = body.get_tem_type()
	#
	#if item_type == 'PotionTesting':
		#gold = gold + 10
		#
	#elif item_type == 'HealingPotion'
		#gold = gold + 5
