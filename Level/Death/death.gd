extends CanvasLayer

@onready var animation = $AnimationPlayer
var done = false

func _ready():
	visible = false
	
func dead():
	$DeadTimer.start(2)

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"dead":
			$BlackTimer.start(.5)
		"fade_out":
			done = true

func _on_timer_timeout():
	$Foreground.visible = true
	animation.play("fade_out")


func _on_dead_timer_timeout():
	visible = true
	animation.play("dead")

func _input(event):
	if event.is_action_pressed("newGame") && done:
		get_tree().change_scene_to_file("res://Menus/start_menu.tscn")
