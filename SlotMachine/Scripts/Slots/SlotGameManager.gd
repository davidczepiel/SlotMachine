class_name SlotGameManager extends GameManager

var result_matrix: Array = []  # Result of the reels

func _ready():
	super._ready()
	# Configure PlayManager
	if play_manager is SlotPlayManager:
		var slot_manager = play_manager as SlotPlayManager
		slot_manager.reels_count = 5
		slot_manager.symbols_per_reel = 3
		slot_manager.symbols_pool = [1, 2, 3, 4, 5]


func get_result_matrix() -> Array:
	return result_matrix
