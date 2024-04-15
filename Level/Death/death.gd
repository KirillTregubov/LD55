extends CanvasLayer

@onready var animation = $AnimationPlayer

func _ready():
	visible = false
	
func dead():
	$DeadTimer.start(2)

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"dead":
			$BlackTimer.start(.5)
		"fade_out":
			animation.stop()
			get_tree().change_scene_to_file("res://Menus/start_menu.tscn")
	

func _on_timer_timeout():
	$Foreground.visible = true
	animation.play("fade_out")


func _on_dead_timer_timeout():
	visible = true
	animation.play("dead")
