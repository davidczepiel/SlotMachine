class_name ReelsGamblingGame extends IGamblingGame

@export var reels: Array[Reel] = []  # References to Reel instances
@export var base_spin_symbols: int = 7  # Base number of symbols to spin
@export var spin_increment: int = 3  # Increment in symbols for each reel in sequence

var is_spinning: bool = false
var num_reels_stopped : int = 0

func start_game():
	if is_spinning:
		stop_game()
		return

	is_spinning = true
	for i in range(reels.size()):
		var symbols_to_spin = base_spin_symbols + (i * spin_increment)
		reels[i].start_spinning(symbols_to_spin)

func stop_game():
	if not is_spinning:
		return  
	for i in range(reels.size()):
		reels[i].stop_spinning()
	is_spinning = false
	num_reels_stopped = 0
	
func on_reel_stopped():
	num_reels_stopped += 1
	if num_reels_stopped == reels.size():
		is_spinning = false
		num_reels_stopped = 0
