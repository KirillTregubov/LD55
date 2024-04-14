extends Node2D
@onready var animation = $AnimationPlayer

func summon():
	animation.play("summon")
