extends Node

var player: Player
var is_in_minigame: bool = false



func minigame_started() -> void:
	is_in_minigame = true
	player.game_state = player.GameState.DISABLED
