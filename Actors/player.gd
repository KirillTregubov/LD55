extends Node2D
@export var character_name: String = "Jaya"
@onready var sprite = $Sprite2D
@onready var small = $Player_small
var canTalk = false

@export var track: AudioStream = preload ("res://Assets/SFX/single_vowel.wav")

func _ready():
	sprite.visible = false
	small.visible = true
	DialogueManager.talk.connect(talk)
	
func talk(isTalking: bool, person: String):
	if person == character_name:
		if isTalking:
			DialogueManager.set_voice(track)
		if isTalking and canTalk:
			sprite.play("talking")
		else:
			sprite.play("default")

func _on_court_case_closeup(speak: bool):
	canTalk = speak
	sprite.visible = speak
	small.visible = !speak
