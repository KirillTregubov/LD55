extends Node2D

@export var opening: Dialogue
@onready var witness_1 = $Subjects/BugWitness
@onready var circle = $Subjects/SummoningCircle

func _ready():
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)


func handle_scripted_events(event: String):
	match event:
		"summon_witness_1":
			handle_summon1()
			
func handle_summon1():
	circle.start_summoning()
	witness_1.summon()
