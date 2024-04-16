extends CanvasLayer
@onready var animation = $AnimationPlayer

func _on_retry_button_pressed() -> void:
	GameManager.quit_to_menu()

func _on_quit_button_pressed() -> void:
	GameManager.quit_game()

func win():
	animation.play("win")
