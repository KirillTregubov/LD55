extends Node2D
@onready var animation = $AnimationPlayer

func summon_bug():
	animation.play("summon_bug")
func summon_chester():
	animation.play("summon_chester")
func summon_abaddon():
	animation.play("summon_abaddon")
func summon_mosquito():
	animation.play("summon_mosquito")
