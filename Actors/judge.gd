extends Node2D
@export var character_name: String = "Judge Belzebufo"
@onready var sprite = $Sprite2D
@export var frog_voice: AudioStream = preload ("res://Assets/SFX/frog_1_vowel.wav")

func _ready():
	DialogueManager.talk.connect(talk)
	
func talk(isTalking: bool, person: String):
	if person == character_name:
		if isTalking:
			sprite.play("talking")
			DialogueManager.set_voice(frog_voice)
		else:
			sprite.play("default")

func mouth_open():
	sprite.play("mouth_open")

func mouth_close():
	sprite.play("default")
