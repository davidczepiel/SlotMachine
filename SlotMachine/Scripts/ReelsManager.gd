extends Node

@export var reels: Array[Reel] = []  # References to Reel instances
@export var base_spin_symbols: int = 20  # Base number of symbols to spin
@export var spin_increment: int = 5  # Increment in symbols for each reel in sequence
@export var stop_delay: float = 0.5  # Delay between stopping reels in seconds

var is_spinning: bool = false

func start_spinning():
	if is_spinning:
		return  # Prevent starting another spin while spinning

	is_spinning = true

	# Start spinning all reels with sequential increments
	for i in range(reels.size()):
		var symbols_to_spin = base_spin_symbols + (i * spin_increment)
		reels[i].start_spinning(symbols_to_spin)

func stop_spinning():
	if not is_spinning:
		return  
	is_spinning = false
