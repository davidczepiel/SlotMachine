class_name GameManager extends Node

var active_scene: Node = null  # Reference to the current SceneManager

func on_enter():
	print(name, "entered.")
	initialize_scenes()

func on_exit():
	print(name, "exited.")
	cleanup_scenes()

func initialize_scenes():
	pass

func cleanup_scenes():
	pass

# Sets the active scene and handles transitions
func set_active_scene(scene: Node) -> void:
	if active_scene and active_scene.has_method("on_exit"):
		active_scene.on_exit()
	active_scene = scene
	if active_scene and active_scene.has_method("on_enter"):
		active_scene.on_enter()
	print("Active scene set to:", active_scene.name if active_scene else "None")

func handle_input(action: String):
	if active_scene and active_scene.has_method("handle_input"):
		active_scene.handle_input(action)
