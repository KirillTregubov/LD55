extends CanvasLayer

@onready var animation = $AnimationPlayer
@onready var track: AudioStream = preload ("res://Assets/SFX/victory_pad.wav")
@onready var menu = $PauseMenu
func _on_retry_button_pressed() -> void:
	GameManager.quit_to_menu()

func _on_quit_button_pressed() -> void:
	GameManager.quit_game()

func win():
	SoundPlayer.play_sound(track)
	menu.queue_free()
	animation.play("win")
