@tool
class_name PaletteSetter
extends Node

@export var white : Color
@export var black : Color

@export_tool_button("Apply", "Theme") var apply = _apply

func _ready() -> void:
	_apply()

func _apply():
	Palette.white = white
	Palette.black = black
