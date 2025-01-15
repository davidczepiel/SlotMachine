class_name Symbol extends PathFollow2D

enum SymbolState { IDLE, PRIZE, OFF }

@onready var IdleSprite: Sprite2D = $IDLE
@onready var PrizeAnimation: AnimatedSprite2D = $PRIZE
@onready var OffSprite: Sprite2D = $OFF

var _current_state: SymbolState = SymbolState.IDLE
var resource : FigureTypeResource 

func _ready():
	IdleSprite.visible = true
	PrizeAnimation.visible = false
	OffSprite.visible = false
	set_state(SymbolState.IDLE)

func set_state(value: SymbolState) -> void:
	_current_state = value
	_update_state()

func setup(resource: FigureTypeResource) -> void:
	self.resource = resource
	IdleSprite.texture = resource.idle_texture
	PrizeAnimation.frames = resource.prize_animation
	OffSprite.texture = resource.off_texture
	set_state(SymbolState.IDLE)

func _update_state() -> void:
	IdleSprite.visible = (_current_state == SymbolState.IDLE)
	PrizeAnimation.visible = (_current_state == SymbolState.PRIZE)
	OffSprite.visible = (_current_state == SymbolState.OFF)
	
	PrizeAnimation.stop()
	if _current_state == SymbolState.PRIZE:
		PrizeAnimation.play()
