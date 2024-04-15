extends CanvasLayer

@onready var animation = $AnimationPlayer
@onready var foreground_container = $ForegroundContainer

var done = false
var shown = false

func _ready():
	visible = false

func dead():
	$DeadTimer.start(2)

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"dead":
			GameManager.reset_game()
			$BlackTimer.start(.2)
		"fade_in":
			shown = true
			done = true

func _on_timer_timeout():
	if not shown:
		animation.play("fade_in")

func _on_dead_timer_timeout():
	visible = true
	animation.play("dead")

func _on_retry_button_pressed() -> void:
	GameManager.start_game()

func _on_quit_button_pressed() -> void:
	GameManager.quit_game()
