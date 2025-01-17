class_name Reel extends Path2D

signal reel_stopped()

@export var visible_symbols: int = 3
@export var spin_speed: float = 200.0
@export var symbol_scene: PackedScene = null
@export var reel_resource : ReelResource  # Reference to the ReelResource

var active_symbols: Array = []  # Symbols actively displayed
var is_spinning: bool = false
var symbols_to_spin: int = 0
var current_index: int = 0  # Tracks current position in the logical reel

func _ready():
	_initialize_symbols()

func start_spinning(sym_to_spin: int = 20):
	symbols_to_spin = sym_to_spin
	is_spinning = true

func _process(delta: float):
	if is_spinning:
		_spin_reel(delta)

func _spin_reel(delta: float):
	for current_symbol in active_symbols:
		var aux = spin_speed * delta
		if current_symbol.progress_ratio + aux > 1.0:
			symbols_to_spin -= 1
			# Update the current index when a symbol wraps around
			current_index = (current_index + 1) % reel_resource.figure_types.size()

		current_symbol.progress_ratio += aux
	# Decrement symbols_to_spin and stop when it reaches 0
	if symbols_to_spin <= 0:
		is_spinning = false
		_align_to_result()

func _initialize_symbols():
	var total_symbols = visible_symbols + 2  # Extra symbols for smooth rotation
	for i in range(total_symbols):
		var new_symbol = symbol_scene.instantiate() as Symbol
		add_child(new_symbol)
		var progress = (float(i) / float(total_symbols))
		new_symbol.progress_ratio = progress

		var figure_type_index = (current_index + i) % reel_resource.figure_types.size()
		var figure_type = reel_resource.figure_types[figure_type_index]
		new_symbol.setup(figure_type)
		active_symbols.append(new_symbol)

func _align_to_result():
	#var symbol_spacing = 1.0 / (visible_symbols + 2)
	#for i in range(active_symbols.size()):
		#active_symbols[i].progress_ratio = i * symbol_spacing
	reel_stopped.emit()
