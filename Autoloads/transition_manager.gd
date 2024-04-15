extends CanvasLayer

@onready var animator = $AnimationPlayer

signal hidden
signal shown

var game_showing = true
var changing = false

func fade_to_black() -> Signal:
	changing = true
	animator.play("fade_to_black")
	return hidden

func fade_from_black() -> Signal:
	changing = true
	animator.play("fade_from_black")
	return shown

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_to_black":
			changing = false
			game_showing = false
			hidden.emit()
		"fade_from_black":
			changing = false
			game_showing = true
			shown.emit()
