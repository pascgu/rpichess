@tool
extends Node

var white : Color:
	set(a):
		white = a
		RenderingServer.global_shader_parameter_set("palette_white", white)
	get:
		return white

var black : Color:
	set(a):
		black = a
		RenderingServer.global_shader_parameter_set("palette_black", black)
	get:
		return black
