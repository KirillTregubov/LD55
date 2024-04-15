extends Node2D
@export var character_name: String = "Jaya"
@onready var sprite = $Sprite2D

var canTalk = false

func _ready():
	DialogueManager.talk.connect(talk)
	
func talk(isTalking:bool, person: String):
	if person == character_name:
		if isTalking and canTalk:
			sprite.play("talking")
		else:
			sprite.play("default")


func _on_court_case_closeup(speak: bool):
	canTalk = speak
