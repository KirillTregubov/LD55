extends CanvasLayer

@onready var container = $VBoxContainer/MarginContainer/ButtonContainer
@onready var button_scene = preload("res://Menus/choice_button.tscn")
@export var audio_track: AudioStream = preload("res://Assets/SFX/select.wav")

func display_choices(words: Array[String], choices: Array[Dialogue]):
	var index = 0
	for line in words:
		var button = button_scene.instantiate()
		button.text = line
		button.lines = choices[index]
		index += 1
		button.pressed.connect(clear_button)
		container.add_child(button)

func clear_button():
	SoundPlayer.play_sound(audio_track)
	for child in container.get_children(): 
		container.remove_child(child)
		child.queue_free() 	
