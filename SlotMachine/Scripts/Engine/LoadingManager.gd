extends Node
class_name LoadingManager

@export var splash_screen: PackedScene = null  # Path to the splash screen scene
@export var hub_scene: PackedScene = null  # Path to the HUB scene (optional)
@export var games_to_load: Array[PackedScene] = []  # Array of games to load
@onready var PrimaryPool : Node = $PrimaryPool
@onready var GamesPool : Node = $GamesPool

var loaded_scenes: Array[Node] = []  # Tracks loaded game scenes

func _ready():
	if splash_screen:
		_load_splash_screen()

func _load_splash_screen():
	var splash = splash_screen.instantiate()
	add_child(splash)
	splash.queue_free()
	_load_games()

func _load_games():
	# Determine if a HUB is needed
	var load_hub = games_to_load.size() > 1

	if load_hub and hub_scene:
		print("Loading HUB...")
		var hub = hub_scene.instantiate()
		add_child(hub)
		loaded_scenes.append(hub)

	# Load the games
	for game_scene in games_to_load:
		print("Loading game:", game_scene)
		var game = game_scene.instantiate()
		add_child(game)
		loaded_scenes.append(game)

	_on_loading_complete()

func _on_loading_complete():
	print("All games loaded. Transitioning to first active scene.")
	# Transition logic to the first scene (e.g., HUB or single game)
	if loaded_scenes.size() == 1:
		_activate_scene(loaded_scenes[0])  # Only one game
	elif loaded_scenes.size() > 1:
		_activate_scene(loaded_scenes[0])  # Start with HUB if present

func _activate_scene(scene: Node):
	# Example logic to activate a scene
	print("Activating scene:", scene.name)
	scene.set_process(true)
