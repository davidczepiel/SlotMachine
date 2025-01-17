class_name ReelPrizeManager extends IPrizeManager

@export var line_patterns: Array = []  # Array of line patterns
@export var paytable: Dictionary = {}  # Symbol ID -> Prize for specific counts

func analyze_game(game_manager: Node) -> int:
	var slot_game_manager = game_manager as SlotGameManager
	var result_matrix = slot_game_manager.get_result_matrix()
	return _calculate_prizes(result_matrix)

func _calculate_prizes(result_matrix: Array) -> int:
	var total_prize = 0
	for line_pattern in line_patterns:
		total_prize += _analyze_line(result_matrix, line_pattern)
	return total_prize

func _analyze_line(result_matrix: Array, line_pattern: Array) -> int:
	var symbol_counts: Dictionary = {}
	var line_symbols = []
	# Extract symbols from the result based on the line pattern
	for position in line_pattern:
		var row = position[0]
		var col = position[1]
		line_symbols.append(result_matrix[row][col])
	# Count occurrences of each symbol
	for symbol in line_symbols:
		if symbol in symbol_counts:
			symbol_counts[symbol] += 1
		else:
			symbol_counts[symbol] = 1
	# Determine the prize for this line
	var line_prize = 0
	for symbol in symbol_counts.keys():
		if symbol in paytable and symbol_counts[symbol] >= 3:  # Example: 3 or more symbols to win
			line_prize = max(line_prize, paytable[symbol] * symbol_counts[symbol])
	return line_prize
