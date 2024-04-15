extends Node2D

signal closeup(canTalk: bool)

@export var opening: Dialogue
@onready var witness_1 = $Subjects/BugWitness
@onready var circle = $Subjects/SummoningCircle
@export var track = preload ("res://Assets/Music/Courtcase Music loop .wav")
@onready var camera = $Camera2D
@onready var lose = preload ("res://Level/lose_condition.tscn")
@onready var foreground = $Foreground
@onready var witness_layer = $Witness
func _ready():
	var shown = TransitionManager.fade_from_black() as Signal
	if not shown.is_null():
		await shown
	
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)

func handle_scripted_events(event: String):
	match event:
		"summon_witness_1":
			handle_summon1()
			
		"start_music":
			start_music()
			
		"camera_enabled":
			camera.enabled = true
			foreground.visible = false
			witness_layer.visible = false
			closeup.emit(true)
		"camera_disabled":
			camera.enabled = false
			foreground.visible = true
			witness_layer.visible = true
			closeup.emit(false)

func handle_summon1():
	circle.start_summoning()
	witness_1.summon()

func start_music():
	MusicPlayer.start_playing(track, -10)

func _on_strikes_dead():
	get_tree().change_scene_to_packed(lose)
