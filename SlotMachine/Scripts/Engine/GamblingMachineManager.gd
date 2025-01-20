class_name GamblingMachineManager extends Node

var active_game: GameManager = null 

# Sets the active game and handles transitions
func set_active_game(game: Node) -> void:
	if active_game and active_game.has_method("on_exit"):
		active_game.on_exit()
	active_game = game
	if active_game and active_game.has_method("on_enter"):
		active_game.on_enter()
