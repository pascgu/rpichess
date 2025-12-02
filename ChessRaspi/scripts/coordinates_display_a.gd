@tool
extends Node3D

@export var size : Vector2i

@export var font_size : int = 100

@export var offset_from_board : float = 0.5

@export_tool_button("Generate", "BitMap") var generate = _generate

var x_axis_labels : Array[Label3D]
var y_axis_labels : Array[Label3D]

func _ready() -> void:
	_generate()

func _process(delta: float) -> void:
	_generate()

func _generate():
	for label in x_axis_labels:
		label.queue_free()
	x_axis_labels.clear()
	for label in y_axis_labels:
		label.queue_free()
	y_axis_labels.clear()
	
	for x in size.x:
		var label : Label3D = Label3D.new()
		x_axis_labels.append(label)
		
		label.text = char(x + 65)
		label.font_size = font_size
		label.modulate = Palette.white
		label.outline_modulate = Palette.black
		label.outline_size = 0
		
		label.rotation = Vector3(-PI/2, 0, 0)
		label.position = Vector3(x + 0.5, 0, offset_from_board)
		
		add_child(label)
	for y in size.y:
		var label : Label3D = Label3D.new()
		y_axis_labels.append(label)
		
		
		label.text = str(y+1)
		label.font_size = font_size
		
		label.rotation = Vector3(-PI/2, 0, 0)
		label.position = Vector3(-offset_from_board, 0, -(y + 0.5))
		label.modulate = Palette.white
		label.outline_modulate = Palette.black
		label.outline_size = 0
		
		add_child(label)
