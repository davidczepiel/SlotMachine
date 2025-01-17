extends Node

@export var reels: Array[Reel] = []  # References to Reel instances
@export var base_spin_symbols: int = 7  # Base number of symbols to spin
@export var spin_increment: int = 5  # Increment in symbols for each reel in sequence
@export var stop_delay: float = 0.5  # Delay between stopping reels in seconds

var is_spinning: bool = false
var num_reels_stopped : int = 0

func start_spinning():
	if is_spinning:
		return  # Prevent starting another spin while spinning

	is_spinning = true
	for i in range(reels.size()):
		var symbols_to_spin = base_spin_symbols + (i * spin_increment)
		reels[i].start_spinning(symbols_to_spin)

func stop_spinning():
	if not is_spinning:
		return  
	is_spinning = false
	
func on_reel_stopped():
	num_reels_stopped += 1
	if num_reels_stopped == reels.size():
		is_spinning = false
		num_reels_stopped = 0
