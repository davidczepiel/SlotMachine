class_name Reel extends Node2D

@export var visible_symbols : int = 3  # Number of visible symbols
@export var spin_speed : float = 200.0  # Speed of reel spinning (pixels/sec)
@export var symbol_scene : Symbol = null

var path_follows: Array = []  # List to store PathFollow2D nodes
var is_spinning: bool = false  # Reel spinning state

func _ready():
	_initialize_symbols()

func _initialize_symbols():
	var total_symbols = visible_symbols + 1 #One extra symbol for seemless rotation
	var path_length = $Path2D.curve.get_baked_length()
	for i in range(total_symbols):
		var path_follow = PathFollow2D.new()
		path_follow.progress_ratio = (i / float(total_symbols + 1))
		var new_symbol = symbol_scene.instantiate()
		path_follow.add_child(new_symbol)
		$Path2D.add_child(path_follow)
		new_symbol.setup(_get_random_texture(), null, null)
		path_follows.append(path_follow)

func start_spinning():
	is_spinning = true

func stop_spinning(target_symbols: Array):
	is_spinning = false
	_align_to_result(target_symbols)

func _process(delta: float):
	if is_spinning:
		_spin_reel(delta)

func _spin_reel(delta: float):
	for path_follow in path_follows:
		path_follow.progress_ratio += spin_speed * delta

func _align_to_result(target_symbols: Array):
	# Adjust the offsets for a clean alignment
	var path_length = $Path2D.curve.get_baked_length()
	var symbol_spacing = 1.0 / (visible_symbols + 2)
	for i in range(path_follows.size()):
		path_follows[i].offset = i * symbol_spacing

func _get_random_texture() -> Texture2D:
	# Placeholder function to return a random texture
	var textures = [
		#preload("res://icon1.png"),
		#preload("res://icon2.png"),
		#preload("res://icon3.png")
	]
	return textures[randi() % textures.size()]
