extends CanvasLayer

@export var prelude_dialogue: Dialogue
@export var gavel_sound: AudioStream = preload ("res://Assets/SFX/gavel_impacts.wav")
@onready var track = preload ("res://Assets/Music/hammond_hill.wav")
@export var voice: AudioStream = preload ("res://Assets/SFX/single_vowel.wav")

func _ready():
	MusicPlayer.start_playing(track, -5)
	
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.set_voice(voice)
	DialogueManager.start_dialogue(prelude_dialogue)

func handle_scripted_events(event: String):
	match event:
		"gavel":
			gavel()
		"court_case":
			court_case()
			
func court_case():
	TransitionManager.fade_from_black() as Signal
	get_tree().change_scene_to_file("res://Level/court_case.tscn")

func gavel():
	SoundPlayer.play_sound(gavel_sound)
