extends Node
signal update_gold()


var player: Player
var is_in_minigame: bool = false
var score
var gold: int = 0





func minigame_started() -> void:
	is_in_minigame = true
	player.game_state = player.GameState.DISABLED

func minigame_ended() -> void:
	is_in_minigame = false
	player.game_state = player.GameState.ACTIVE
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
