class_name Reel extends Path2D

signal reel_stopped()

@export var visible_symbols: int = 3
@export var spin_speed: float = 200.0
@export var symbol_scene: PackedScene = null
@export var reel_resource : ReelResource  # Reference to the ReelResource

@export var spin_factor: float = 1.0  # We'll animate this via AnimationPlayer
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var active_symbols: Array = []  # Symbols actively displayed
var is_spinning: bool = false
var symbols_to_spin: int = 0
var current_index: int = 0  # Tracks current position in the logical reel

func _ready():
	_initialize_symbols()

func start_spinning(sym_to_spin: int = 20):
	symbols_to_spin = sym_to_spin
	is_spinning = true
	var local_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	spin_factor = 0
	local_tween.tween_property(self, "spin_factor", 1, 0.25)
	#animation_player.play("start_spin")
	
func stop_spinning():
	is_spinning = false
	var local_tween = create_tween()
	var spin_val = 0.3
	var spin_time = 0.07
	spin_factor = spin_val
	local_tween.tween_property(self, "spin_factor", 0, spin_time)
	local_tween.tween_property(self, "spin_factor", -spin_val, spin_time)
	local_tween.tween_callback(_align_to_result)

func _process(delta: float):
	_spin_reel(delta)

func _spin_reel(delta: float):
	var movement = spin_speed * spin_factor * delta
	for current_symbol in active_symbols:
		if current_symbol.progress_ratio + movement > 1.0:
			symbols_to_spin -= 1
			if is_spinning and symbols_to_spin <= 0:
				stop_spinning()
			# Update the current index when a symbol wraps around
			current_index = (current_index + 1) % reel_resource.figure_types.size()
			active_symbols.remove_at(active_symbols.find(current_symbol))
			active_symbols.push_front(current_symbol)
		current_symbol.progress_ratio += movement

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
		active_symbols.push_back(new_symbol)

func _align_to_result():
	spin_factor = 0
	var symbol_spacing = 1.0 / (visible_symbols + 2)
	for i in range(active_symbols.size()):
		active_symbols[i].progress_ratio = i * symbol_spacing
	reel_stopped.emit()
