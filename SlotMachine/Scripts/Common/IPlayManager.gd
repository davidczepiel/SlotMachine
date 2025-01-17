class_name IPlayManager extends Node

# Prepare the next game state (to be implemented by subclasses)
func prepare_next_result():
	pass

# Retrieve the current result (to be implemented by subclasses)
func get_result() -> Dictionary:
	return {}
