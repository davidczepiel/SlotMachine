class_name GameManager extends Node

@export var packed_scenes: Array[PackedScene] = []
var instantiated_scenes: Dictionary = {}
var play_manager: IPlayManager = null

var active_scene: Node = null
var is_active: bool = true  

func _ready():
	# Configure PlayManager
	if play_manager is SlotPlayManager:
		var slot_manager = play_manager as SlotPlayManager
		slot_manager.reels_count = 5
		slot_manager.symbols_per_reel = 3
		slot_manager.symbols_pool = [1, 2, 3, 4, 5]

	# Assign the PlayManager to all SceneManagers
	for scene_manager in instantiated_scenes:
		scene_manager.set_play_manager(play_manager)

func on_enter():
	print(name, "entered.")
	initialize_scenes()

func on_exit():
	print(name, "exited.")
	active_scene.on_exit()

func initialize_scenes():
	for packed_scene in packed_scenes:
		var scene = packed_scene.instantiate()
		var scene_name = scene.name
		instantiated_scenes[scene_name] = scene
		print("Scene instantiated:", scene_name)
		add_child(scene)
	print("All scenes initialized.")

func set_active_scene(scene_name: String) -> void:
	if not instantiated_scenes.has(scene_name):
		print("Scene not found:", scene_name)
		return
	active_scene.on_exit()
	active_scene = instantiated_scenes[scene_name]
	add_child(active_scene)
	if active_scene.has_method("on_enter"):
		active_scene.on_enter()
	emit_signal("scene_entered", active_scene.name if active_scene else "Unknown")
	print("Active scene set to:", active_scene.name if active_scene else "None")

func handle_input(action: String):
	if is_active and active_scene and active_scene.has_method("handle_input"):
		active_scene.handle_input(action)

# Retrieves the current state for debugging
func get_state() -> Dictionary:
	return {
		"active_scene": active_scene.name if active_scene else "None",
		"available_scenes": instantiated_scenes.keys(),
		"is_active": is_active
	}
