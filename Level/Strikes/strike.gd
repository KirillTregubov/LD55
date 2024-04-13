extends Panel
class_name Strike

@onready var sprite = $Sprite

func set_used() -> void:
	sprite.frame = 1

func reset() -> void:
	sprite.frame = 0

