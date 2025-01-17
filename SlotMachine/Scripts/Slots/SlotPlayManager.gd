class_name SlotPlayManager extends IPlayManager

# Variables for slot-specific logic
var current_result: Dictionary = {}
@export var reels_count: int = 5           # Number of reels
@export var symbols_per_reel: int = 3      # Number of symbols per reel
@export var symbols_pool: Array = []       # Array of available symbols

# Prepare the next reel and line results
func prepare_next_result():
	# Generate random reel results
	var reels_result = []
	for i in range(reels_count):
		var reel = []
		for j in range(symbols_per_reel):
			reel.append(symbols_pool[randi() % symbols_pool.size()])
		reels_result.append(reel)

	# Example: Randomized line results (can be extended)
	var line_results = [
		{"line_id": 1, "symbol": 2, "count": 3, "prize": 100},
		{"line_id": 2, "symbol": 4, "count": 5, "prize": 200},
	]

	# Store the result
	current_result = {
		"reels": reels_result,
		"lines": line_results
	}

# Retrieve the current result
func get_result() -> Dictionary:
	return current_result
