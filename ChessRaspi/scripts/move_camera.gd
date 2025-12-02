class_name MoveCamera
extends Node3D

@export var rotate_speed : Vector2
@export var zoom_speed : float = 1.0
@export var fov_speed : float = 10.0

@onready var camera : Camera3D = $Camera3D

func _process(delta: float) -> void:
	var a : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	rotate_y(a.x * rotate_speed.x * delta)
	rotate_object_local(Vector3.RIGHT, a.y * rotate_speed.y * delta)
	
	var b : float = Input.get_axis("zoom_out", "zoom_in")
	camera.position += Vector3(0, b * zoom_speed * delta, 0)
	
	var c : float = Input.get_axis("fov_minus", "fov_plus")
	camera.fov += c * fov_speed * delta
