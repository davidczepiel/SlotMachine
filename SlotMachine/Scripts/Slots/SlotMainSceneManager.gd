class_name SlotMainSceneManager extends SceneManager

@onready var reels_manager = $ReelsManager  # Reference to the ReelsManager

func on_enter():
	print(name, "scene entered.")

func on_exit():
	print(name, "scene exited.")

func handle_input(action: String):
	match action:
		"play":
			_handle_play()
		"help":
			print("Help input received (to be implemented).")

# Handles the play action
func _handle_play():
	# Delegate money-related logic to PrimaryGame
	if Globals.PrimaryGame.has_enough_money(10):  # Assuming 10 is the cost of spinning
		Globals.PrimaryGame.deduct_money(10)  # Deduct the cost
		reels_manager.start_spinning()  # Trigger the ReelsManager to spin
	else:
		print("Not enough credits!")
