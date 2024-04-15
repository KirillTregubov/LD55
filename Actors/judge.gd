extends Node2D
@export var character_name: String = "Judge Belzebufo"
@onready var sprite = $Sprite2D
@export var frog_voice: AudioStream = preload("res://Assets/SFX/fish_talking.wav")

func _ready():
	DialogueManager.talk.connect(talk)
	
func talk(isTalking:bool, person: String):
	if person == character_name:
		if isTalking:
			sprite.play("talking")
			DialogueManager.set_voice(frog_voice)
		else:
			sprite.play("default")
