extends Node2D

@export var dialogue: Dialogue

func _ready():
	DialogueManager.start_dialogue(dialogue)
