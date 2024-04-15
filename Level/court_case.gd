extends Node2D

@export var opening: Dialogue
@onready var witness_1 = $Subjects/BugWitness
@onready var circle = $Subjects/SummoningCircle
@onready var music = $Music

@onready var lose = preload ("res://Level/lose_condition.tscn")

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
	music.play()

func _on_music_finished():
	music.play()

func _on_strikes_dead():
	get_tree().change_scene_to_packed(lose)
