extends Node2D

signal closeup(canTalk: bool)

@export var opening: Dialogue
@onready var small_witness = $Subjects/SmallWitness
@onready var circle = $Subjects/SummoningCircle
@export var track = preload ("res://Assets/Music/Courtcase Music loop .wav")
@onready var camera = $Camera2D
@onready var lose = preload ("res://Level/lose_condition.tscn")
@onready var foreground = $Foreground
@onready var witness_layer = $Witness

func _ready():
	MusicPlayer.stop_playing()
	foreground.visible = false
	closeup.emit(true)
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)

func handle_scripted_events(event: String):
	match event:
		"summon_bug":
			small_witness.visible = true
			summon_bug_witness()	
			
		"summon_chester":
			small_witness.visible = true
			summon_chester_witness()
			
		"summon_abaddon":
			small_witness.visible = true
			summon_abaddon_witness()
			
		"summon_mosquito":
			small_witness.visible = true
			summon_mosquito_witness()
		"unsummon":
			small_witness.visible = false
			
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
			
		"crowd_pleased":
			foreground.crowd_pleased()
			
		"crowd_surprised":
			foreground.crowd_surprised()
			
		"win":
			get_tree().change_scene_to_file("res://Level/win_condition.tscn")

func summon_bug_witness():
	circle.start_summoning()
	small_witness.summon_bug()

func summon_chester_witness():
	circle.start_summoning()
	small_witness.summon_chester()
	
func summon_abaddon_witness():
	circle.start_summoning()
	small_witness.summon_abaddon()

func summon_mosquito_witness():
	circle.start_summoning()
	small_witness.summon_mosquito()

func start_music():
	MusicPlayer.start_playing(track, -10)

func _on_strikes_dead():
	get_tree().change_scene_to_packed(lose)


func _on_summoning_circle_start():
	MusicPlayer.stop_playing()
func _on_summoning_circle_stop():
	MusicPlayer.start_playing(track, -10)
