extends CanvasLayer

@onready var animation = $AnimationPlayer

func fade_to_black():
	animation.play("fade_to_black")
	
func fade_from_black():
	animation.play("fade_from_black")
