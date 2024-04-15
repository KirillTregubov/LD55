extends CanvasLayer

@export var prelude_dialogue: Dialogue
@export var gavel_sound:AudioStream = preload("res://Assets/SFX/gavel_impacts.wav")
@onready var track = preload ("res://Assets/Music/hammond_hill.wav")
func _ready():
	MusicPlayer.start_playing(track, -5)
	var shown = TransitionManager.fade_from_black() as Signal
	if not shown.is_null():
		await shown
	
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(prelude_dialogue)

func handle_scripted_events(event: String):
	match event:
		"gavel":
			gavel()
		"court_case":
			court_case()
			
func court_case():
	get_tree().change_scene_to_file("res://Level/court_case.tscn")
func gavel():
	SoundPlayer.play_sound(gavel_sound)
