class_name SceneManager extends Node

# Reference to the PlayManager
var play_manager: IPlayManager = null

func on_enter():
	print(name, "scene entered.")

func on_exit():
	print(name, "scene exited.")

# Handles input specific to the scene
func handle_input(action: String):
	match action:
		"play":
			print(name, "handling 'play' input.")
		"help":
			print(name, "handling 'help' input.")

# Set the PlayManager reference
func set_play_manager(manager: IPlayManager) -> void:
	play_manager = manager
