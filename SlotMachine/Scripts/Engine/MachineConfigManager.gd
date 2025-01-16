extends Node
class_name ConfigurationManager

@export var product_name: String = "Default Product"
@export var version: String = "1.0.0"
@export var initial_market: MARKET = MARKET.BAR


enum MARKET { BAR, SALON, CASINO }

var machine_id: String = "MACHINE001"  # Default value
var allow_bill_acceptor: bool = true
var allow_ticket_printer: bool = false
var allow_coin_mechanism: bool = true


func get_product_info() -> String:
	return "Product: %s, Version: %s, Market: %s" % [
		product_name,
		version,
		str(initial_market)
	]

func set_allow_bill_acceptor(enabled: bool) -> void:
	allow_bill_acceptor = enabled

func is_bill_acceptor_allowed() -> bool:
	return allow_bill_acceptor

func set_machine_id(new_id: String) -> void:
	machine_id = new_id

func get_machine_id() -> String:
	return machine_id
