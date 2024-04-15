extends CanvasLayer

signal exit
@onready var DisplaySettings = $MarginContainer/VBoxContainer/Visuals
@onready var master = $MarginContainer/VBoxContainer/Audio/Master/HSlider
@onready var music = $MarginContainer/VBoxContainer/Audio/Music/HSlider
@onready var sfx = $MarginContainer/VBoxContainer/Audio/SFX/HSlider

const RESOLUTION_DISPLAY: Dictionary = {
	"640x360": Vector2i(640, 360),
	"1280x720": Vector2i(1280, 720),
	"1920x1080": Vector2i(1920, 1080)
}

func _on_back_button_pressed():
	exit.emit()

func _on_screen_toggle_toggled(display_mode):
	match display_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_vs_toggle_toggled(toggled_on):
	if toggled_on == 0:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_resolution_selected(index):
	print('before ', DisplayServer.window_get_size())
	print(DisplayServer.window_get_mode())
	#var window := get_window() as Window
	#window.set_size(RESOLUTION_DISPLAY.values()[index])
	#OS.window_size = RESOLUTION_DISPLAY.values()[index]
	var new_size = RESOLUTION_DISPLAY.values()[index]
	DisplayServer.window_set_size(new_size)
	#get_window().content_scale_size = new_size
	print(RESOLUTION_DISPLAY.values()[index])
	print(DisplayServer.window_get_size())

func _on_master_value_changed(value):
	if (value == master .min_value):
		AudioServer.set_bus_mute(0, true)
	else:
		volume(0, value)
	
func volume(bus_index, value):
	AudioServer.set_bus_mute(bus_index, false)
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_music_value_changed(value):
	if (value == music.min_value):
		AudioServer.set_bus_mute(1, true)
	else:
		volume(1, value)

func _on_sfx_value_changed(value):
	if (value == sfx.min_value):
		AudioServer.set_bus_mute(2, true)
	else:
		volume(2, value)

func _input(_event) -> void:
	if visible == true and Input.is_action_just_pressed("close"):
		exit.emit()

func _ready() -> void:
	match OS.get_name():
		"Web":
			DisplaySettings.visible = false
