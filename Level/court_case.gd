extends Node2D

@export var opening: Dialogue
@onready var witness_1 = $Subjects/BugWitness
@onready var circle = $Subjects/SummoningCircle

@onready var lose = preload ("res://Level/lose_condition.tscn")
@onready var track = preload("res://Assets/Music/Courtcase Music loop .wav")

func _ready():
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)

func handle_scripted_events(event: String):
	match event:
		"summon_witness_1":
			handle_summon1()
			
		"start_music":
			start_music()

func handle_summon1():
	circle.start_summoning()
	witness_1.summon()

func start_music():
	MusicPlayer.set_target_volume( - 10)
	MusicPlayer.set_track(track)
	MusicPlayer.start_playing()
	pass

func _on_strikes_dead():
	get_tree().change_scene_to_packed(lose)
