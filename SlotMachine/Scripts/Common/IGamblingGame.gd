class_name IGamblingGame extends Node

var is_active: bool = false

func start_game():
	is_active = true

func stop_game():
	is_active = false
	
func is_game_active() -> bool:
	return is_active
