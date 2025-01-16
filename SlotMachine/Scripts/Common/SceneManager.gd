class_name SceneManager extends Node

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
