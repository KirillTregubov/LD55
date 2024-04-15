extends Node

var SCALE: float = 1.0

func _ready() -> void:
	var window := get_window() as Window
	var screen_scale = DisplayServer.screen_get_scale()
	if (window.content_scale_factor != screen_scale):
		SCALE = screen_scale / window.content_scale_factor
		window.size = window.size * SCALE
		window.move_to_center()

func _input(_event):
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			get_window().move_to_center()
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
