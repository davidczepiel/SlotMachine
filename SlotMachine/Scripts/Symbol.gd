class_name Symbol extends Node2D

enum SymbolState { IDLE, WIN, OFF }
@onready var IdleSprite : Sprite2D = $IDLE
@onready var WinAnimation : AnimatedSprite2D = $IDLE
@onready var OffSprite : Sprite2D = $IDLE

var _current_state: SymbolState = SymbolState.IDLE 

func set_state(value: SymbolState) -> void:
	_current_state = value
	_update_state()

func get_state()->SymbolState:
	return _current_state
	
func setup(idle_texture: Texture2D, win_frames: SpriteFrames, off_texture: Texture2D) -> void:
	IdleSprite.texture = idle_texture
	WinAnimation.frames = win_frames
	OffSprite.texture = off_texture
	set_state(SymbolState.IDLE)

func _update_state() -> void:
	IdleSprite.visible = (_current_state == SymbolState.IDLE)
	WinAnimation.visible = (_current_state == SymbolState.WIN)
	OffSprite.visible = (_current_state == SymbolState.OFF)
	
	WinAnimation.stop()
	if _current_state == SymbolState.WIN:
		WinAnimation.play()
