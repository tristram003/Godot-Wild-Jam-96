extends CanvasLayer


@onready var gold_label: Label = $GoldLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gamemaster.update_gold.connect(on_gold_update)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass


func on_gold_update():
	gold_label.text = str(Gamemaster.gold)
