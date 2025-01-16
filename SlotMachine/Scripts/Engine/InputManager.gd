class_name InputManager extends Node

enum InputAction { PLAY, CHANGE_BET, AUTO, MAX_BET, STOP }

var active_manager: Node = null  # The currently active manager

# Map raw input (strings, hardware events) to InputAction enums
var input_mappings = {
	"button_play": InputAction.PLAY,
	"button_change_bet": InputAction.CHANGE_BET,
	"button_auto": InputAction.AUTO,
	"button_max_bet": InputAction.MAX_BET,
	"button_stop": InputAction.STOP
}

# Set the active manager
func set_active_manager(manager: Node) -> void:
	if active_manager and active_manager.has_method("on_manager_exit"):
		active_manager.on_manager_exit()

	active_manager = manager

	if active_manager and active_manager.has_method("on_manager_enter"):
		active_manager.on_manager_enter()

	print("Active manager set to:", active_manager.name if active_manager else "None")

# Process input from the external source
func handle_input(raw_input: String):
	if raw_input in input_mappings:
		var action = input_mappings[raw_input]
		_delegate_input(action)
	else:
		print("Unhandled input:", raw_input)

# Delegate the translated input to the active manager
func _delegate_input(action: InputAction):
	if active_manager and active_manager.has_method("handle_input"):
		active_manager.handle_input(action)
