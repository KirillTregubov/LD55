extends CanvasLayer

signal exit
@onready var master = $MarginContainer/VBoxContainer/Audio/Master/HSlider
@onready var music = $MarginContainer/VBoxContainer/Audio/Music/HSlider
@onready var sfx = $MarginContainer/VBoxContainer/Audio/SFX/HSlider

const RESOLUTION_DISPLAY : Dictionary = {
	"800x600" : Vector2(800,600),
	"1280x720" : Vector2(1280,720),
	"1920x1080" : Vector2(1920,1080)
}

func _on_back_button_pressed():
	exit.emit()


func _on_screen_toggle_toggled(toggled_on):
	if toggled_on==0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
func _on_vs_toggle_toggled(toggled_on):
	if toggled_on==0:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_resolution_selected(index):
	DisplayServer.window_set_size(RESOLUTION_DISPLAY.values()[index])


func _on_master_value_changed(value):
	if(value == master.min_value):
		AudioServer.set_bus_mute(1, true)
	else:
		volume(1, value)
	
func volume(bus_index, value):
	AudioServer.set_bus_mute(bus_index, false)
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_music_value_changed(value):
	if(value == music.min_value):
		AudioServer.set_bus_mute(2, true)
	else:
		volume(2, value)


func _on_sfx_value_changed(value):
	if(value == sfx.min_value):
		AudioServer.set_bus_mute(3, true)
	else:
		volume(3,value)

