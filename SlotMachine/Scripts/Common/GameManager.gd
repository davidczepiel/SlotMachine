class_name GameManager extends Node

@export var game_scenes: Array[PackedScene] = []
@export var play_manager: IPlayManager = null
@export var main_scene_name : String = "MainScene"

var instantiated_scenes: Dictionary = {}
var active_scene: Node = null

func _ready():
	initialize_scenes()
	# Assign the PlayManager to all SceneManagers
	for scene_name in instantiated_scenes:
		instantiated_scenes[scene_name].set_play_manager(play_manager)

func on_enter():
	print(name, " entered.")
	set_active_scene(main_scene_name)
	active_scene.on_enter()

func on_exit():
	print(name, " exited.")
	active_scene.on_exit()

func initialize_scenes():
	for current_packed_scene in game_scenes:
		var scene = current_packed_scene.instantiate()
		var scene_name = scene.name
		instantiated_scenes[scene_name] = scene
		print("Scene instantiated:", scene_name)
		add_child(scene)

func set_active_scene(scene_name: String) -> void:
	if not instantiated_scenes.has(scene_name):
		print("Scene not found:", scene_name)
		return
	active_scene.on_exit()
	active_scene = instantiated_scenes[scene_name]
	if active_scene.has_method("on_enter"):
		active_scene.on_enter()

func handle_input(action: String):
	if active_scene and active_scene.has_method("handle_input"):
		active_scene.handle_input(action)
