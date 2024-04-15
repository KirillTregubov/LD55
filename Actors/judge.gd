extends Node2D
@export var character_name: String = "Judge Belzebufo"
@onready var sprite = $Sprite2D
func _ready():
	DialogueManager.talk.connect(talk)
	
func talk(isTalking:bool, person: String):
	if person == character_name:
		if isTalking:
			sprite.play("talking")
		else:
			sprite.play("default")
